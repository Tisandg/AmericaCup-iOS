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
    
    static let defaultCover = UIImage(named: "escudo.png")!
    var nameTeamA:String
    var nameTeamB:String
    var result:String
    var date:String
    
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
    
    
    init(teamA:String,teamB:String,result:String,date:String,cover:UIImage? = nil) {
        self.nameTeamA = teamA
        self.nameTeamB = teamB
        self.result = result
        self.date = date
    }
}
