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
    
    func removeToFavorites(id: Int){
        guard let db = getOpenDB() else { return }
        do {
            let rsUpdate = try db.executeUpdate("UPDATE 'Team' set favorite = (?) WHERE id = (?)", values: [0,id])
            //Update favorites
            print("Remove to favorites")
            self.favorites = loadFavorites()
        } catch {
            print("failed change to favorite: \(error.localizedDescription)")
        }
    }
    
    func getTeam(id:Int)->Team{
        //Opens a connection to DB
        var team = Team.init()
        guard let db = getOpenDB() else { return team }
        do {
            //Queries database for all books
            let rs = try db.executeQuery("SELECT * FROM 'Team' WHERE id = (?)", values:[id])
            //Iterates throughout the Result Set
            while rs.next() {
                //Creates a Book object from Result Set
                if let teamRS = Team(rs: rs) {
                    //Add to Books array for updating the interface
                    team = teamRS
                }
            }
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        //Closes the connection to database
        db.close()
        return team
    }
    
    func changeToFavorite(id:Int)->Int{
        var favorite:Int = -1
        guard let db = getOpenDB() else { return favorite }
        do {
            let rs = try db.executeQuery("SELECT * FROM 'Team' WHERE id = (?)", values:[id])
            //Iterates throughout the Result Set
            while rs.next() {
                var aux = rs.int(forColumn: "favorite")
                print("respuesta: "+String(aux))
                if(Int(aux) == 0){
                    favorite = 1
                }else{
                    favorite = 0
                }
            }
            let rsUpdate = try db.executeUpdate("UPDATE 'Team' set favorite = (?) WHERE id = (?)", values: [favorite,id])
            
            //Llamar a favorites
            self.favorites = loadFavorites()
            
        } catch {
            print("failed change to favorite: \(error.localizedDescription)")
        }
        return favorite
    }
    
    func addTeam(_ team:Team) {
        var team = team
        //Adds the record in the database
        SQLAddTeam(team: &team)
    }
    
    func SQLAddTeam(team:inout Team) {
        guard let db = getOpenDB() else { return  }
        do {
            try db.executeUpdate(
                "insert into Team (id, name, group_id, favorite, team_detail_id) values (?, ?, ?, ?, ?)",
                values: [team.team_id, team.team_name, team.group_id, team.favorite, team.team_detail_id]
            )
        } catch {
            print("failed: \(error.localizedDescription)")
        }
        //Closes the connection to the database
        db.close()
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

