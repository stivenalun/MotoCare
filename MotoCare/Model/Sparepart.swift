//
//  Sparepart.swift
//  MotoCare
//
//  Created by Nur Hidayatul Fatihah on 08/11/23.
//

import Foundation
import SwiftData

@Model
class Sparepart {
    var name: String
    var lastServiceMileage: Int
    
    var motorcycle: Motorcycle?
    
    init(name: String = "", lastServiceMileage: Int = 0) {
        self.name = name
        self.lastServiceMileage = lastServiceMileage
    }
}
