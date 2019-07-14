//
//  TeamManager.swift
//  AmericaCup
//
//  Created by Santiago Garcia on 7/14/19.
//  Copyright © 2019 Santiago Garcia. All rights reserved.
//

import Foundation
import UIKit

class TeamManager{
    
    //Store the groups collection
    private lazy var favorites:[Team] = self.loadFavorites()
    //Store the number of books in the collection
    var favoritesCount:Int {return favorites.count}
    
    //Return the books collection
    private func loadFavorites()->[Team] {
        //for now, loads a dummy hard-coded books collection
        return sampleFavorites()
    }
    
    func getFavorite(at index:Int)->Team {
        return favorites[index]
    }
    
    //Return a dummny collection of books according to Book structure
    private func sampleFavorites()->[Team] {
        return [
            Team(nombre: "Colombia", ganados: 3, empatados: 0, perdidos: 0, puntos: 9),
            Team(nombre: "Brazil", ganados: 2, empatados: 1, perdidos: 0, puntos: 7)
        ]
    }

}

