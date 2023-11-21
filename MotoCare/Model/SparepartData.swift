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
    var name: String
    var checkIntervalInKilometer: Int?
    var replaceIntervalInKilometer: Int

    init(name: String = "", replaceIntervalInKilometer: Int = 0, checkIntervalInKilometer: Int = 0) {
        self.name = name
        self.replaceIntervalInKilometer = replaceIntervalInKilometer
        self.checkIntervalInKilometer = checkIntervalInKilometer
    }
}


struct Sparepart: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var checkIntervalInKilometer: Int?
    var replaceIntervalInKilometer: Int
    var type: SparepartType
    var icon: String
    var image: String
    
    static func == (lhs: Sparepart, rhs: Sparepart) -> Bool {
        return lhs.id == rhs.id
    }
}

enum SparepartType: String, Codable {
    case busi = "Busi"
    case vbelt = "V-Belt"
    case olimesin = "Oli Mesin"
    case oligardan = "Oli Gardan"
    case airfilter = "Air Filter"
}

let sparepartData = [
    Sparepart(name: "Busi", checkIntervalInKilometer: 4000, replaceIntervalInKilometer: 8000, type: .busi, icon: "spark-plug", image: "SparkPlugImage"),
    Sparepart(name: "Air Filter", checkIntervalInKilometer: 16000, replaceIntervalInKilometer: 16000, type: .airfilter, icon: "air-filter", image: "AirFilterImage"),
    Sparepart(name: "Oli Mesin", checkIntervalInKilometer: 0, replaceIntervalInKilometer: 4000, type: .olimesin, icon: "engine-oil", image: "EngineOilImage"),
    Sparepart(name: "Oli Gardan", checkIntervalInKilometer: 4000, replaceIntervalInKilometer: 12000, type: .oligardan, icon: "final-drive-oil", image: "FinalDriveOilImage"),
    Sparepart(name: "V-Belt", checkIntervalInKilometer: 8000, replaceIntervalInKilometer: 25000, type: .vbelt, icon: "v-belt", image: "VBeltImage")
]

