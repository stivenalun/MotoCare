//
//  Motorcycle.swift
//  MotorCareSwiftData
//
//  Created by Nur Hidayatul Fatihah on 30/10/23.
//

import SwiftUI
import SwiftData

@Model
class Motorcycle {
    var brand: String
    var currentMileage: Int
    @Relationship(deleteRule: .cascade) var spareparts: [SparepartHistory]?
    
    init(brand: String = "Yamaha Lexi", currentMileage: Int = 0) {
        self.brand = brand
        self.currentMileage = currentMileage
    }
}


