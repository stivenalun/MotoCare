//
//  MaintenanceHistoryView.swift
//  MotorCareSwiftData
//
//  Created by Nur Hidayatul Fatihah on 31/10/23.
//

import SwiftUI

struct MaintenanceLog: Identifiable {
    let id = UUID()
    let date: Date
    let sparePartType: String
    let quantityReplaced: Int
}

struct MaintenanceHistoryView: View {
    // Sample data for demonstration
    let maintenanceLogs: [MaintenanceLog] = [
        MaintenanceLog(date: Date(), sparePartType: "Spark Plug", quantityReplaced: 4),
        MaintenanceLog(date: Date(), sparePartType: "Battery", quantityReplaced: 1),
        MaintenanceLog(date: Date(), sparePartType: "Oil Filter", quantityReplaced: 1),
    ]

    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                List(maintenanceLogs) { log in
                    VStack(alignment: .leading) {
                        Text("Date: \(formattedDate(log.date))")
                        Text("Spare Part: \(log.sparePartType)")
                        Text("Quantity Replaced: \(log.quantityReplaced)")
                            
                    } .listRowBackground(Color.white.opacity(0.5))
                } .scrollContentBackground(.hidden)
                .navigationTitle("History")
            }
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
}


#Preview {
    MaintenanceHistoryView()
}

