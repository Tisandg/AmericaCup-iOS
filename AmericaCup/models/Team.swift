//
//  Team.swift
//  AmericaCup
//
//  Created by Santiago Garcia on 7/14/19.
//  Copyright © 2019 Santiago Garcia. All rights reserved.
//

import Foundation
import UIKit

internal struct KeyTeam{
    static let id:String = "id"
    static let name:String = "name"
    static let group_id:String = "group_id"
    static let favorite:String = "favorite"
    static let team_detail_id:String = "team_detail_id"
}

struct Team{
    
    static let defaultCover = UIImage(named: "escudo.png")!
    var team_name:String
    var team_id:Int
    var group_id:Int
    var favorite:Int
    var team_detail_id:Int
    
    //Use a default cover if none is set
    var cover:UIImage {
        get {
            return image ?? Team.defaultCover
        }
        set {
            image = newValue
        }
    }
    private var image:UIImage? = nil
    
    init(id:Int, name:String, favorite:Int, team_detail_id:Int, group_id:Int) {
        self.team_id = id
        self.team_name = name
        self.favorite = favorite
        self.team_detail_id = team_detail_id
        self.group_id = group_id
    }

    init?(rs:FMResultSet) {
        let id = rs.int(forColumn: KeyTeam.id)
        let group_id = rs.int(forColumn: KeyTeam.group_id)
        let favorite = rs.int(forColumn: KeyTeam.favorite)
        let team_detail_id = rs.int(forColumn: KeyTeam.team_detail_id)
        guard let name = rs.string(forColumn: KeyTeam.name)
            else{   return nil  }
        self.init(id:Int(group_id), name:name, favorite:Int(favorite), team_detail_id:Int(team_detail_id), group_id:Int(group_id))
    }
    
}
