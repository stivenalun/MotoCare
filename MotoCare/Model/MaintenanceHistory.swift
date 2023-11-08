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
    @Attribute(.unique) var id_maintenancehistory: UUID
    var date: Date?
    var lastServiceMileage: Int
    var selectedSpareparts: [String]
    
    init(id_maintenancehistory: UUID, date: Date? = nil, lastServiceMileage: Int, selectedSpareparts: [String]) {
        self.id_maintenancehistory = id_maintenancehistory
        self.date = date
        self.lastServiceMileage = lastServiceMileage
        self.selectedSpareparts = selectedSpareparts
    }
}
