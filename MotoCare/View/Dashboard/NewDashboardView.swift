//
//  NewDashboardView.swift
//  MotoCare
//
//  Created by Nur Hidayatul Fatihah on 04/11/23.
//

import SwiftUI
import SwiftData

struct NewDashboardView: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var motorcycleVM : MotorcycleViewModel
    
    @Query var motorcycles: [Motorcycle]
    @Query var maintenanceHistory: [MaintenanceHistory]
    
    @State private var isModalPresented = false
    @State private var selectedItem: SparepartData?
    
    var body: some View {
        NavigationView {
//            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        ZStack {
                            Image("BackDashboard")
                            VStack(alignment: .leading) {
                                Text("Yamaha Lexi S ABS")
                                    .font(.system(size: 14))
                                    .foregroundColor(.white)
                                    .padding(.leading, 30)
                                    .padding(.top)
                                    
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(.white)
                                        .frame(width: 330, height: 104)
                                        .onTapGesture {
                                            isModalPresented = true
                                        }
                                    VStack(alignment: .leading) {
                                        Text("Jarak Tempuh")
                                            .font(.title3)
                                            .fontWeight(.medium)
                                            .foregroundColor(.black)
                                            .padding(.leading, 20)
                                        HStack {
                                            Image(systemName: "gauge.open.with.lines.needle.33percent")
                                                .resizable()
                                                .frame(width: 39, height: 34)
                                                .foregroundColor(.black)
                                            VStack(alignment: .leading) {
                                                Text("\(motorcycleVM.motorcycle.currentMileage ) Km")
                                                    .font(.largeTitle)
                                                    .foregroundColor(.black)
                                                    .fontWeight(.bold)
                                            }
                                        }
                                        .padding(.leading, 20)

                                    }
                                }
                                .sheet(isPresented: $isModalPresented) {
                                    // Tampilkan konten sheet modal di sini
                                    ModalOdometerView()
                                }
                                
                                
                                
                                Button(action: {}) {
                                    Text("Check-In Perbaikan")
                                        .font(.callout)
                                        .fontWeight(.medium)
                                        .foregroundStyle(.black)
                                }
                                .padding(10)
                                .frame(width: 330, alignment: .center)
                                .background(Color("TabIconColor"))
                                .cornerRadius(11)
                            }
                        }
                        .frame(width: 357, height: 232)
                    }
                    
                    StatusSparepartView(motorcycle: motorcycleVM.motorcycle)
                    
                }
                .padding()
                .navigationBarTitle("Dashboard")
//            }
            
        }
    }
}

struct StatusSparepartView : View{
    let motorcycle: Motorcycle
    
    @State private var text: String = ""
    @Environment(\.modelContext) private var modelContext
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Status Spare Part")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            List(motorcycle.spareparts ?? []) { sparepart in
                Text("\(sparepart.name) -  \(estimateSparepartStatus(lastServiceMillage:sparepart.lastServiceMileage, currentMillage: motorcycle.currentMileage, type: sparepart.sparepartType))")

            }
        }
    }
    
    func estimateSparepartStatus(lastServiceMillage: Int, currentMillage: Int, type: SparepartType) -> String {
        let totalMillageFromService = currentMillage - lastServiceMillage
        
        guard var checkIntervalMillage = sparepartData.filter { sparepart in
            sparepart.type == type
        }.first?.checkIntervalInKilometer else { return "" }
        
        guard var replaceIntervalMillage = sparepartData.filter { sparepart in
            sparepart.type == type
        }.first?.replaceIntervalInKilometer  else { return "" }
        
//        print(checkIntervalMillage)
//        print(replaceIntervalMillage)
        
        if totalMillageFromService <= checkIntervalMillage && totalMillageFromService >= replaceIntervalMillage {
            return "CHECK"
        } else if totalMillageFromService >= replaceIntervalMillage {
            return "GANTI"
        } else {
            return "AMAN"
        }
    }
}

#Preview {
    NewDashboardView()
}
