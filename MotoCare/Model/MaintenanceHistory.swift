//
//  MaintenanceHistory.swift
//  MotorCareSwiftData
//
//  Created by Nur Hidayatul Fatihah on 30/10/23.
//

import Foundation
import SwiftData

@Model
class MaintenanceHistory {
    var date: Date
    var maintenanceMileage: Double
    @Relationship var sparePartHistory: [SparepartHistory]
    
    init(date: Date, maintenanceMileage: Double, sparePartHistory: [SparepartHistory]) {
        self.date = date
        self.maintenanceMileage = maintenanceMileage
        self.sparePartHistory = sparePartHistory
    }
    
}
