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
    var lastServiceMileage: Int
    var motorcycle: Motorcycle?
    var sparepartType: SparepartType
    
    init(name: String = "", lastServiceMileage: Int = 0, sparepartType: SparepartType) {
        self.name = name
        self.lastServiceMileage = lastServiceMileage
        self.sparepartType = sparepartType
    }
}
