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
    
    var nombre:String
    var ganados:Int
    var empatados:Int
    var perdidos:Int
    var puntos:Int
    
    init(nombre:String, ganados:Int, empatados:Int, perdidos:Int, puntos:Int) {
        self.nombre = nombre
        self.ganados = ganados
        self.empatados = empatados
        self.perdidos = perdidos
        self.puntos = puntos
    }
    
    
}
