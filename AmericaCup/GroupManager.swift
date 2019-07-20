//
//  GroupManager.swift
//  AmericaCup
//
//  Created by Santiago Garcia on 7/14/19.
//  Copyright © 2019 Santiago Garcia. All rights reserved.
//

import Foundation

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

class GroupManager{
    
    //Store the groups collection
    private lazy var groups:[Group] = self.loadGroups()
    
    //Store the number of books in the collection
    var groupCount:Int {return groups.count}

    //Get a book from the collection at a specific position
    func getGroup(at index:Int)->Group {
        return groups[index]
    }

    //Return the books collection
    private func loadGroups()->[Group] {
        //for now, loads a dummy hard-coded books collection
        return retrieveGroups() ?? []
        //return sampleGroups()
    }

    //Add a book to the collection
    func addGroup(_ group:Group) {
        groups.append(group)
    }
    
    //Uses the FMDB wrapper to get a reference to the Books database on the specific path
    public func getOpenDB()->FMDatabase? {
        let db = FMDatabase(path: dbFile.path)
        guard db.open() else {
            print("Unable to open database")
            return nil
        }
        return db
    }
    
    //Retrieves all books from Books database
    func retrieveGroups() -> [Group]? {
        //Opens a connection to DB
        guard let db = getOpenDB() else { return nil }
        var groups:[Group] = []
        do {
            //Queries database for all books
            let rs = try db.executeQuery("SELECT * FROM 'Group'",values:nil)
            while rs.next() {
                if var group = Group(rs: rs) {
                    var teams:[Team] = []
                    let rsTeams = try db.executeQuery("SELECT * FROM 'Team' WHERE group_id = (?)",values:[group.id])
                    while rsTeams.next() {
                        if let team = Team(rs: rsTeams) {
                            teams.append(team)
                        }
                    }
                    group.teams = teams
                    groups.append(group)
                }
            }
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        //Closes the connection to database
        db.close()
        return groups
    }
    
    


}
