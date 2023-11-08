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
//                                                Text("\(motorcycles.first?.currentMileage ?? 0) Km")
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
                    
                    
//                    SectionView(title: "Rekomendasi Penggantian", data: filterData(category: .needReplacement), showModal: $showModal, selectedItem: $selectedItem)
//                    SectionView(title: "Rekomendasi Pengecekan", data: filterData(category: .checkingRequired), showModal: $showModal, selectedItem: $selectedItem)
//                    SectionView(title: "Kondisi Bagus", data: filterData(category: .safeToGo), showModal: $showModal, selectedItem: $selectedItem)
                }
                .padding()
                .navigationBarTitle("Dashboard")
//            }
            
        }
    }
}

struct StatusSparepartView : View{
//    @EnvironmentObject var motorcycleVM : MotorcycleViewModel
    
    let motorcycle: Motorcycle
    
    @State private var text: String = ""
    @Environment(\.modelContext) private var modelContext
//    @Query var sparepart: [Sparepart]
    
//    let data: [SparepartData]
//    @Binding var showModal: Bool
//    @Binding var selectedItem: SparepartData?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Status Spare Part")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            List(motorcycle.spareparts ?? []) { sparepart in
                Text("\(sparepart.name) - \(sparepart.lastServiceMileage)")
                
            }
//            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
//                ForEach(data, id: \.value) { data in
//                    Button(action: {
//                        self.selectedItem = data
//                        self.showModal.toggle()
//                    })
//                }
//            }
        }
    }
}

//let newgaugeData: [SparepartData] = [
//    SparepartData(name: "Air Filter", replaceIntervalInKilometer: 16000, icon: "air-filter", image: "AirFilterImage"),
//    SparepartData(name: "Busi", checkIntervalInKilometer: 4000, replaceIntervalInKilometer: 5000, icon: "spark-plug", image: "SparkPlugImage"),
//    SparepartData(name: "V-Belt",checkIntervalInKilometer: 8000, replaceIntervalInKilometer: 25000, icon: "v-belt", image: "VBeltImage"),
//    SparepartData(name: "Oli Mesin", replaceIntervalInKilometer: 4000, icon: "engine-oil", image: "EngineOilImage"),
//    SparepartData(name: "Oli Gardan", checkIntervalInKilometer: 4000, replaceIntervalInKilometer: 12000, icon: "final-drive-oil", image: "FinalDriveOilImage")
//]

#Preview {
    NewDashboardView()
}
