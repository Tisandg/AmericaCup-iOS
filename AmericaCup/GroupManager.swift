//
//  GroupManager.swift
//  AmericaCup
//
//  Created by Santiago Garcia on 7/14/19.
//  Copyright © 2019 Santiago Garcia. All rights reserved.
//

import Foundation

class GroupManager {
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
        return sampleGroups()
    }

    //Add a book to the collection
    func addGroup(_ group:Group) {
        groups.append(group)
    }

    //Return a dummny collection of books according to Book structure
    private func sampleGroups()->[Group] {
        let team1 = Team(nombre: "Colombia", ganados: 3, empatados: 0, perdidos: 0, puntos: 9)
        let team2 = Team(nombre: "Argentina", ganados: 3, empatados: 0, perdidos: 0, puntos: 9)
        let team3 = Team(nombre: "Paraguay", ganados: 3, empatados: 0, perdidos: 0, puntos: 9)
        let team4 = Team(nombre: "Qatar", ganados: 3, empatados: 0, perdidos: 0, puntos: 9)
        let teams = [team1, team2, team3, team4]
        return [
            Group(nameGroup:"Group A", teams:teams),
            Group(nameGroup:"Group B",teams:teams),
            Group(nameGroup:"Group C",teams:teams)
        ]
    }
}
