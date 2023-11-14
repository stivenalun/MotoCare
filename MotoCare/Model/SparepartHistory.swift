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
    
    init(name: String = "", sparepartType: SparepartType) {
        self.name = name
        self.sparepartType = sparepartType
    }
}
