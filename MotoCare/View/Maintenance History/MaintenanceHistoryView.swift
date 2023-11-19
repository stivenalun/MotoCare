//
//  MaintenanceHistoryView.swift
//  MotorCareSwiftData
//
//  Created by Nur Hidayatul Fatihah on 31/10/23.
//

import SwiftUI
import SwiftData

struct MaintenanceHistoryView: View {
   
   @Query var maintenanceHistories: [MaintenanceHistory]
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
//                  Rectangle()
//                      .foregroundColor(.clear)
//                      .frame(width: 357, height: 115)
//                      .background(
//                          LinearGradient(
//                              stops: [
//                                 Gradient.Stop(color: Color(red: 0.2, green: 0.29, blue: 0.3).opacity(0.98), location: 0.00),
//                                 Gradient.Stop(color: Color(red: 0.08, green: 0.09, blue: 0.09), location: 1.00),
//                              ],
//                              startPoint: UnitPoint(x: 0.5, y: 0),
//                              endPoint: UnitPoint(x: 0.5, y: 1)
//                          )
//                      )
//                      .cornerRadius(20)
//                      .overlay(
//                          HStack(alignment: .top) {
//                              Text("\(sparepartHistories.count) spare part diganti")
//                                 .font(.system(size: 17))
//                                 .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                                 .foregroundColor(.white)
//                                 .padding(.leading, 15)
//                                 .padding(.top, -40)
//                              Spacer()
//                          }
//                      )
//                  Spacer()
               }
           } 
           .scrollContentBackground(.hidden)
           .navigationBarTitle("Riwayat")
       }
   }
}

#Preview {
    MaintenanceHistoryView()
}

