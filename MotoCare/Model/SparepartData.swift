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
//    var checkIntervalInMonth: Int?
    var replaceIntervalInKilometer: Int
//    var replaceIntervalInMonth: Int?
//    var icon: String
//    var image: String
//    var lastServiceMileage: Int
    
    
//    init(name: String = "", checkIntervalInKilometer: Int? = nil, checkIntervalInMonth: Int? = nil, replaceIntervalInKilometer: Int = 0, replaceIntervalInMonth: Int? = nil, icon: String = "", image: String = "", lastServiceMileage: Int = 0) {
//        self.name = name
//        self.checkIntervalInKilometer = checkIntervalInKilometer
//        self.checkIntervalInMonth = checkIntervalInMonth
//        self.replaceIntervalInKilometer = replaceIntervalInKilometer
//        self.replaceIntervalInMonth = replaceIntervalInMonth
//        self.icon = icon
//        self.image = image
//        self.lastServiceMileage = lastServiceMileage
//    }
    
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
    
    static func == (lhs: Sparepart, rhs: Sparepart) -> Bool {
        return lhs.id == rhs.id
    }
}

enum SparepartType: Codable {
    case busi
    case vbelt
    case olimesin
    case oligear
    case airfilter
}
let sparepartData = [
    Sparepart(name: "Busi",checkIntervalInKilometer: 4000, replaceIntervalInKilometer: 8000, type: .busi),
    Sparepart(name: "Air Filter", replaceIntervalInKilometer: 16000, type: .airfilter),
    Sparepart(name: "Oli Mesin", replaceIntervalInKilometer: 4000, type: .olimesin),
    Sparepart(name: "Oli Gear", checkIntervalInKilometer: 4000, replaceIntervalInKilometer: 12000, type: .oligear),
    Sparepart(name: "V-Belt", checkIntervalInKilometer: 8000, replaceIntervalInKilometer: 25000, type: .vbelt)
]
