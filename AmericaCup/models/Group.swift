//
//  Group.swift
//  AmericaCup
//
//  Created by Santiago Garcia on 7/14/19.
//  Copyright © 2019 Santiago Garcia. All rights reserved.
//

import Foundation
import UIKit

internal struct KeyGroup{
    static let group_id:String = "id"
    static let group_name:String = "name"
}

struct Group{
    
    var id:Int
    var name:String
    var teams:[TeamPosition] = []
    
    init(id:Int, nameGroup:String) {
        self.id = id
        self.name = nameGroup
    }
    
    
    init?(rs:FMResultSet) {
        let group_id = rs.int(forColumn: KeyGroup.group_id)
        guard let group_name = rs.string(forColumn: KeyGroup.group_name)
            else{   return nil  }
        self.init(id:Int(group_id), nameGroup: group_name)
    }
    
}
