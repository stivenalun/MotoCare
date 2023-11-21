//
//  MaintenanceHistoryView.swift
//  MotorCareSwiftData
//
//  Created by Nur Hidayatul Fatihah on 31/10/23.
//

import SwiftUI
import SwiftData

struct MaintenanceHistoryView: View {
    
   @Query(sort: \MaintenanceHistory.date, order: .reverse) var maintenanceHistories: [MaintenanceHistory]
   @Query var sparepartHistories: [SparepartHistory]
   
   var body: some View {
       NavigationView {
           ZStack {
               BackgroundView()
               VStack {
                  List(maintenanceHistories) { history in
                      VStack(alignment: .leading) {
                          Text("\(history.sparePartHistory.count) spare part diganti")
                              .font(.title3)
                              .fontWeight(.semibold)
                          Text("Date: \(history.date)")
                          Text("Maintenance Mileage: \(history.maintenanceMileage)")
                      }
                  }
//                  .scrollContentBackground(.hidden)
               }
               .scrollContentBackground(.hidden)
           }
           .scrollContentBackground(.hidden)
           .navigationBarTitle("Riwayat")
       }
   }
}

#Preview {
    MaintenanceHistoryView()
}

