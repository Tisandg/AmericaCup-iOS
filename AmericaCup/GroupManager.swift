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
                            print("Agregando team [",team.team_id,"] al group [",group.id,"]")
                            teams.append(team)
                        }
                    }
                    
                    var teamsPosition:[TeamPosition] = []
                    //Order the groups
                    for team in teams{
                        //print("Agregando team [",team.team_id,"]a la position")
                        var won:Int = 0
                        var drawn:Int = 0
                        var lost:Int = 0
                        var points:Int = 0
                        
                        // match home
                        let reMatchHome = try db.executeQuery("SELECT * FROM 'Match' WHERE match_id_team_a = (?)",values:[team.team_id])
                        while reMatchHome.next() {
                            
                            guard let score = reMatchHome.string(forColumn: "score")
                                else{   return nil  }
                            let arrayString = score.components(separatedBy: " - ")
                            let goalA = Int(arrayString[0])
                            let goalB = Int(arrayString[1])
                            if goalA! > goalB! {
                                won = won + 1
                            }
                            if goalA! < goalB! {
                                lost = lost + 1
                            }
                            if(goalA! == goalB!){
                                drawn = drawn + 1
                            }
                        }
                        
                        //match away
                        let reMatchAway = try db.executeQuery("SELECT * FROM 'Match' WHERE match_id_team_b = (?)",values:[team.team_id])
                        while reMatchAway.next() {
                            guard let score = reMatchAway.string(forColumn: "score")
                                else{   return nil  }
                            
                            print("Escore: "+score)
                            let arrayString = score.components(separatedBy: " - ")
                            let goalA = Int(arrayString[0])
                            let goalB = Int(arrayString[1])
                            if goalA! > goalB! {
                                lost = lost + 1
                            }
                            if goalA! < goalB! {
                                won = won + 1
                            }
                            if(goalA! == goalB!){
                                drawn = drawn + 1
                            }
                        }
                        points = (won*3) + (drawn*1)
                        let teamPosition = TeamPosition.init(name: team.team_name, won: won, drawn: drawn, lost: lost, points: points)
                        teamsPosition.append(teamPosition)
                        
                    }
                    let teamPositionOrdered = teamsPosition.sorted(by: { $0.points > $1.points })
                    group.teams = teamPositionOrdered
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
