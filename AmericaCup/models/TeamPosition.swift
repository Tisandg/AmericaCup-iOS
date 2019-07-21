//
//  TeamPosition.swift
//  AmericaCup
//
//  Created by Santiago Garcia on 7/21/19.
//  Copyright © 2019 Santiago Garcia. All rights reserved.
//

import Foundation

struct TeamPosition{
    
    var nameTeam:String
    var won:Int
    var drawn:Int
    var lost:Int
    var points:Int
    
    init(name:String, won:Int, drawn:Int, lost:Int, points:Int){
        self.nameTeam = name
        self.won = won
        self.drawn = drawn
        self.lost = lost
        self.points = points
    }
    
}
