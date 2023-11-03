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
    @Attribute(.unique) var id_spareparthistory: String
    var status: String
    @Relationship var maintenanceHistory: MaintenanceHistory
    @Relationship var sparePart: SparepartData
    
    init(id_spareparthistory: String, status: String, maintenanceHistory: MaintenanceHistory, sparePart: SparepartData) {
        self.id_spareparthistory = id_spareparthistory
        self.status = status
        self.maintenanceHistory = maintenanceHistory
        self.sparePart = sparePart
    }
}
