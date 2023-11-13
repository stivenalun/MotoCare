//
//  MaintenanceHistoryView.swift
//  MotorCareSwiftData
//
//  Created by Nur Hidayatul Fatihah on 31/10/23.
//

//import SwiftUI
//
//struct MaintenanceLog: Identifiable {
//    let id = UUID()
//    let date: Date
//    let sparePartType: String
//    let quantityReplaced: Int
//}
//
//struct MaintenanceHistoryView: View {
//    // Sample data for demonstration
//    let maintenanceLogs: [MaintenanceLog] = [
//        MaintenanceLog(date: Date(), sparePartType: "Spark Plug", quantityReplaced: 4),
//        MaintenanceLog(date: Date(), sparePartType: "Battery", quantityReplaced: 1),
//        MaintenanceLog(date: Date(), sparePartType: "Oil Filter", quantityReplaced: 1),
//    ]
//
//    var body: some View {
//        NavigationView {
//            ZStack {
//                BackgroundView()
//                List(maintenanceLogs) { log in
//                    VStack(alignment: .leading) {
//                        Text("Date: \(formattedDate(log.date))")
//                        Text("Spare Part: \(log.sparePartType)")
//                        Text("Quantity Replaced: \(log.quantityReplaced)")
//                            
//                    } .listRowBackground(Color.white.opacity(0.5))
//                } .scrollContentBackground(.hidden)
//                .navigationTitle("History")
//            }
//        }
//    }
//    
//    func formattedDate(_ date: Date) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMM d, yyyy"
//        return dateFormatter.string(from: date)
//    }
//}

import SwiftUI

struct MaintenanceHistoryView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                VStack{
                    Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 357, height: 115)
                    .background(
                    LinearGradient(
                    stops: [
                    Gradient.Stop(color: Color(red: 0.2, green: 0.29, blue: 0.3).opacity(0.98), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.08, green: 0.09, blue: 0.09), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.5, y: 0),
                    endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                    )
                    .cornerRadius(20)
                    .overlay(
                        HStack(alignment: .top) {
                            Text("3 Sparepart diganti")
                                .font(.system(size: 17))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.white)
                                .padding(.leading, 15)
                                .padding(.top, -40)
                                Spacer()
                        }
                    )
                    Spacer()
                }
            } .navigationBarTitle("Riwayat")
        }
    } 
}


#Preview {
    MaintenanceHistoryView()
}

