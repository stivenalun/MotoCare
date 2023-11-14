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
    var maintenanceMileage: Int
    @Relationship var sparePartHistory: [SparepartHistory] = [SparepartHistory]()
    
    init(date: Date, maintenanceMileage: Int) {
        self.date = date
        self.maintenanceMileage = maintenanceMileage
    }
    
}
