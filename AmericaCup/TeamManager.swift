//
//  TeamManager.swift
//  AmericaCup
//
//  Created by Santiago Garcia on 7/14/19.
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

class TeamManager{
    
    //Store the groups collection
    private lazy var favorites:[Team] = self.loadFavorites()
    //Store the number of books in the collection
    var favoritesCount:Int {return favorites.count}
    
    //Return the books collection
    private func loadFavorites()->[Team] {
        //for now, loads a dummy hard-coded books collection
        return retrieveFavorites() ?? []
    }
    
    func getFavorite(at index:Int)->Team {
        return favorites[index]
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
    
    //Retrieves all books from Books database
    func retrieveFavorites() -> [Team]? {
        //Opens a connection to DB
        guard let db = getOpenDB() else { return nil }
        var favorites:[Team] = []
        do {
            //Queries database for all books
            let rs = try db.executeQuery("SELECT * FROM 'Team' WHERE favorite = (?)", values:[1])
            //Iterates throughout the Result Set
            while rs.next() {
                //Creates a Book object from Result Set
                if let team = Team(rs: rs) {
                    //Add to Books array for updating the interface
                    favorites.append(team)
                }
            }
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        //Closes the connection to database
        db.close()
        return favorites
    }
    
    //Return a dummny collection of books according to Book structure
    private func sampleFavorites()->[Team] {
        return [
            
        ]
    }

}

