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
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
        .modelContainer(for: Motorcycle.self)
    }
}
