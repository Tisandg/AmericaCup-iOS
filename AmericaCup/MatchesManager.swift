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
            try FileManager().createDirectory(at: url,
                                              withIntermediateDirectories: false)
        } catch let error as NSError {
            print("\(error.localizedDescription)")
        }
        
    }
    //Returns the path
    return url
}()

//Gets URL to db.sql file
private var dbFile:URL = {
    let filePath = appSupportDirectory.appendingPathComponent("db").appendingPathExtension("sql")
    print(filePath)
    if !FileManager().fileExists(atPath: filePath.path) {
        if let bundleFilePath = Bundle.main.resourceURL?.appendingPathComponent("db").appendingPathExtension("sql") {
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
        //for now, loads a dummy hard-coded books collection
        return sampleMatches()
    }

    //Add a book to the collection
    func addMatch(_ match:Match) {
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

    //Return a dummny collection of books according to Book structure
    private func sampleMatches()->[Match] {
        return [
            /*Match(teamA:"Colombia",teamB:"Qatar",result:"1–0",date:"05/07/2019"),
            Match(teamA:"Argentina",teamB:"Paraguay",result:"1–1",date:"05/07/2019"),
            Match(teamA:"Brazil",teamB:"Bolivia",result:"3–0",date:"05/07/2019"),
            Match(teamA:"Chile",teamB:"Ecuador",result:"2–1",date:"05/07/2019"),
            Match(teamA:"Paraguay",teamB:"Colombia",result:"0–1",date:"05/07/2019"),
            Match(teamA:"Brazil",teamB:"Peru",result:"5–0", date:"05/07/2019")*/
        ]
    }
    
}
