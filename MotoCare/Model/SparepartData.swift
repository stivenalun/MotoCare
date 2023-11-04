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
    @Attribute(.unique) var id_sparepartdata: UUID
    var name: String
    var checkIntervalInKilometer: Int?
    var checkIntervalInMonth: Int?
    var replaceIntervalInKilometer: Int
    var replaceIntervalInMonth: Int?
    var icon: String
    var image: String
    
    init(id_sparepartdata: UUID, name: String, checkIntervalInKilometer: Int? = nil, checkIntervalInMonth: Int? = nil, replaceIntervalInKilometer: Int, replaceIntervalInMonth: Int? = nil, icon: String, image: String) {
        self.id_sparepartdata = id_sparepartdata
        self.name = name
        self.checkIntervalInKilometer = checkIntervalInKilometer
        self.checkIntervalInMonth = checkIntervalInMonth
        self.replaceIntervalInKilometer = replaceIntervalInKilometer
        self.replaceIntervalInMonth = replaceIntervalInMonth
        self.icon = icon
        self.image = image
    }
}
