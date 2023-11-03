//
//  Sparepart.swift
//  MotorCareSwiftData
//
//  Created by Nur Hidayatul Fatihah on 30/10/23.
//

import Foundation
import SwiftData

@Model
class SparepartData {
    @Attribute(.unique) var id_sparepartdata: String
    var name: String
    var durabilityInKilometer: Double
    var durabilityInMonth: Int
    var icon: String
    
    init(id_sparepartdata: String, name: String, durabilityInKilometer: Double, durabilityInMonth: Int, icon: String) {
        self.id_sparepartdata = id_sparepartdata
        self.name = name
        self.durabilityInKilometer = durabilityInKilometer
        self.durabilityInMonth = durabilityInMonth
        self.icon = icon
    }
}
