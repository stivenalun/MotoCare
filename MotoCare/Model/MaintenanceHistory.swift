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
    @Attribute(.unique) var id_maintenancehistory: String
    var date: Date
    var maintenanceMileage: Double
    @Relationship var sparePartHistory: SparepartHistory
    
    init(id_maintenancehistory: String, date: Date, maintenanceMileage: Double, sparePartHistory: SparepartHistory) {
        self.id_maintenancehistory = id_maintenancehistory
        self.date = date
        self.maintenanceMileage = maintenanceMileage
        self.sparePartHistory = sparePartHistory
    }
    
}
