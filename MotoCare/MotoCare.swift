//
//  MotorCareSwiftDataApp.swift
//  MotorCareSwiftData
//
//  Created by Nur Hidayatul Fatihah on 30/10/23.
//

import SwiftUI
import SwiftData

@main
struct MotorCareSwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            OpeningOnboardingView()
//            TestView()
        }
//        .modelContainer(for: [Motorcycle.self, SparepartData.self, MaintenanceHistory.self, SparepartHistory.self])
        .modelContainer(for: [Motorcycle.self])
    }
}
