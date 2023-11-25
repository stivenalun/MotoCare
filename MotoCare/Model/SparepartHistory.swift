//
//  SparepartHistory.swift
//  MotorCareSwiftData
//
//  Created by Nur Hidayatul Fatihah on 30/10/23.
//

import Foundation
import SwiftData

@Model
class SparepartHistory {
    var name: String
    var sparepartType: SparepartType
    var maintenanceMileage: Int
    var createdAt: Date
    
    init(name: String = "", sparepartType: SparepartType, maintenanceMileage: Int) {
        self.name = name
        self.sparepartType = sparepartType
        self.maintenanceMileage = maintenanceMileage
        self.createdAt = Date()
    }
}
