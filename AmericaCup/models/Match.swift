//
//  Match.swift
//  AmericaCup
//
//  Created by Santiago Garcia on 7/8/19.
//  Copyright © 2019 Santiago Garcia. All rights reserved.
//

import Foundation
import UIKit

internal struct Key {
    static let match_id = "match_id"
    static let match_id_team_a = "match_id_team_a"
    static let match_id_team_b = "match_id_team_b"
    static let team_a = "teamA"
    static let team_b = "teamB"
    static let score = "score"
    static let match_date = "match_date"
    static let match_hour = "match_hour"
    static let match_stadium = "match_stadium"
}


struct Match{
    
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
    
    init?(rs:FMResultSet) {
        let match_id = rs.int(forColumn: Key.match_id)
        let match_id_team_a = rs.int(forColumn: Key.match_id_team_a)
        let match_id_team_b = rs.int(forColumn: Key.match_id_team_b)
        guard let team_a = rs.string(forColumn: Key.team_a),
            let team_b = rs.string(forColumn: Key.team_b),
            let score = rs.string(forColumn: Key.score),
            let match_date = rs.string(forColumn: Key.match_date),
            let match_hour = rs.string(forColumn: Key.match_hour),
            let match_stadium = rs.string(forColumn: Key.match_stadium)
        else{   return nil  }
        self.init(idMatch:Int(match_id),
                  idTeamA:Int(match_id_team_a),
                  idTeamB:Int(match_id_team_b),
                  teamA:team_a,
                  teamB:team_b,
                  result:score,
                  date:match_date,
                  hour:match_hour,
                  stadium:match_stadium,
                  idGroup:1
        )
    }
}
