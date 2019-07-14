//
//  Team.swift
//  AmericaCup
//
//  Created by Santiago Garcia on 7/14/19.
//  Copyright © 2019 Santiago Garcia. All rights reserved.
//

import Foundation
import UIKit

class Team{
    
    static let defaultCover = UIImage(named: "escudo.png")!
    var nombre:String
    var ganados:Int
    var empatados:Int
    var perdidos:Int
    var puntos:Int
    var favorite:Bool
    
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
    
    init(nombre:String, ganados:Int, empatados:Int, perdidos:Int, puntos:Int) {
        self.nombre = nombre
        self.ganados = ganados
        self.empatados = empatados
        self.perdidos = perdidos
        self.puntos = puntos
        self.favorite = false
    }
    
    
}
