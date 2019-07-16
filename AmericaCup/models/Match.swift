//
//  Match.swift
//  AmericaCup
//
//  Created by Santiago Garcia on 7/8/19.
//  Copyright © 2019 Santiago Garcia. All rights reserved.
//

import Foundation
import UIKit

class Match{
    
    var match_id:Int
    var match_id_team_a:Int
    var match_id_team_b:Int
    var team_a:String
    var team_b:String
    var score:String
    var match_date:String
    var match_hour:String
    var match_stadium:String
    var group_id:Int
    
    static let defaultCover = UIImage(named: "escudo.png")!
    
    //Use a default cover if none is set
    var coverA:UIImage {
        get {
            return imageA ?? Match.defaultCover
        }
        set {
            imageA = newValue
        }
    }
    
    //Use a default cover if none is set
    var coverB:UIImage {
        get {
            return imageB ?? Match.defaultCover
        }
        set {
            imageB = newValue
        }
    }
    
    private var imageA:UIImage? = nil
    private var imageB:UIImage? = nil
    
    init(idMatch: Int, idTeamA:Int, idTeamB:Int, teamA:String,teamB:String,result:String,date:String,hour:String,stadium:String, idGroup:Int? = nil,coverA:UIImage? = nil, coverB:UIImage? = nil) {
        self.match_id = idMatch
        self.match_id_team_a = idTeamA
        self.match_id_team_b = idTeamB
        self.team_a = teamA
        self.team_b = teamB
        self.score = result
        self.match_date = date
        self.match_hour = hour
        self.match_stadium = stadium
        self.group_id = idGroup ?? 1
    }
}
