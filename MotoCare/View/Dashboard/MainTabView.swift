//
//  MainTabView.swift
//  MotorCareSwiftData
//
//  Created by Nur Hidayatul Fatihah on 31/10/23.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Image(systemName: "gauge.open.with.lines.needle.33percent")
                    Text("Dashboard")
                }
            
            MaintenanceHistoryView()
                .tabItem {
                    Image(systemName: "clock.arrow.circlepath")
                    Text("History")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
        .navigationBarBackButtonHidden(true)
        .accentColor(Color("TabIconColor"))
    }
}

#Preview {
    MainTabView()
}
