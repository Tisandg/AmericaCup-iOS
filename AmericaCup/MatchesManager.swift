//
//  MatchesManager.swift
//  AmericaCup
//
//  Created by Santiago Garcia on 7/8/19.
//  Copyright © 2019 Santiago Garcia. All rights reserved.
//

import Foundation
import UIKit

// Get a URL to Application Support directory
private var appSupportDirectory:URL = {
    let url = FileManager().urls(for:.applicationSupportDirectory,in: .userDomainMask).first!
    //Checks if directory exists
    if !FileManager().fileExists(atPath: url.path) {
        //Creates directory if necessary
        do {
            try FileManager().createDirectory(at: url, withIntermediateDirectories: false)
        } catch let error as NSError {
            print("\(error.localizedDescription)")
        }
    }
    //Returns the path
    return url
}()

//Gets URL to db.sql file
private var dbFile:URL = {
    let filePath = appSupportDirectory.appendingPathComponent("db").appendingPathExtension("db")
    print(filePath)
    if !FileManager().fileExists(atPath: filePath.path) {
        if let bundleFilePath = Bundle.main.resourceURL?.appendingPathComponent("db").appendingPathExtension("db") {
            do {
                try FileManager().copyItem(at: bundleFilePath, to: filePath)
            } catch let error as NSError {
                //fingers crossed
                print("\(error.localizedDescription)")
            }
        }
    }
    return filePath
}()

class MatchesManager {
    
    //Store the books collection
    private lazy var matches:[Match] = self.loadMatches()
    
    //Store the number of books in the collection
    var matchCount:Int {return matches.count}

    //Get a book from the collection at a specific position
    func getMatch(at index:Int)->Match {
        return matches[index]
    }

    //Return the books collection
    private func loadMatches()->[Match] {
        //Loads the books from database
        return retrieveMatches() ?? []
    }

    //Add a book to the collection
    func addMatch(_ match:Match) {
        /*As the book object is updated with the ID, you’ll need to mark the argument with an ampersand
         to make this parameter mutable, so you’ll need to reassign it as a variable*/
        var match = match
        //Adds the record in the database
        SQLAddMatch(match: &match)
        //Updates the array with GUI update purposes
        matches.append(match)
    }
    
    //Uses the FMDB wrapper to get a reference to the Books database on the specific path
    func getOpenDB()->FMDatabase? {
        let db = FMDatabase(path: dbFile.path)
        guard db.open() else {
            print("Unable to open database")
            return nil
        }
        return db
    }
    
    func SQLAddMatch(match:inout Match) {
        //Opens a connection to the database
        guard let db = getOpenDB() else { return  }
        do {
            //Performs an update operation on the database
            try db.executeUpdate(
                //Add a Book record
                "insert or replace into Match (match_id, match_id_team_a, match_id_team_b, team_a, team_b, score, match_date, status, group_id) values (?, ?, ?, ?, ?, ?, ?, ?, ?)",
                values: [match.match_id, match.match_id_team_a, match.match_id_team_b, match.team_a, match.team_b, match.score, match.match_date, match.status,match.group_id]
            )
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        //Closes the connection to the database
        db.close()
    }
    
    //Retrieves all books from Books database
    func retrieveMatches() -> [Match]? {
        //Opens a connection to DB
        guard let db = getOpenDB() else { return nil }
        var matches:[Match] = []
        do {
            //Queries database for all books
            let rs = try db.executeQuery("SELECT * FROM Match", values: nil)
            //Iterates throughout the Result Set
            while rs.next() {
                //Creates a Book object from Result Set
                if let match = Match(rs: rs) {
                    //Add to Books array for updating the interface
                    matches.append(match)
                }
            }
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        //Closes the connection to database
        db.close()
        return matches
    }

    
}
