//
//  Motorcycle.swift
//  MotorCareSwiftData
//
//  Created by Nur Hidayatul Fatihah on 30/10/23.
//

import SwiftUI
import SwiftData

@Model
final class Motorcycle {
    @Attribute(.unique) var id_motorcycle: UUID
    var currentMileage: Int
    
    init(id_motorcycle: UUID, currentMileage: Int) {
        self.id_motorcycle = id_motorcycle
        self.currentMileage = currentMileage
    }
}


