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
    //   @Query var sparepartHistories: [SparepartHistory]
    @Query var sparepartHistories: [SparepartHistory]
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                VStack {
                    List(maintenanceHistories) { history in
                        VStack(alignment: .leading) {
                            Spacer()
                            HStack {
                                Text("\(history.date.formatted(.dateTime.day().month().year()))")
                                Spacer()
                                Text("\(history.sparePartHistory.count) spare part diganti")
                                    .fontWeight(.semibold)
                            }
                            Spacer()
                            HStack {
                                let sparePartNames = history.sparePartHistory.map { $0.name }.joined(separator: ", ")
                                Text(sparePartNames)
                            }
                            Spacer()
                        }
                    }
                }
            }
            .navigationBarTitle("Riwayat")
        }
    }
}

#Preview {
    MaintenanceHistoryView()
}

