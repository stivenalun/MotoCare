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
//    var checkIntervalInKilometer: Int?
//    var checkIntervalInMonth: Int?
//    var replaceIntervalInKilometer: Int
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
    
    init(name: String = "") {
        self.name = name
    }
}
