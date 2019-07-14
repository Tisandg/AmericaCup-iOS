//
//  Group.swift
//  AmericaCup
//
//  Created by Santiago Garcia on 7/14/19.
//  Copyright © 2019 Santiago Garcia. All rights reserved.
//

import Foundation
import UIKit

class Group{
    
    var nameGroup:String
    var teams:[Team]
    
    init(nameGroup:String, teams:[Team]) {
        self.nameGroup = nameGroup
        self.teams = teams
    }
    
}
