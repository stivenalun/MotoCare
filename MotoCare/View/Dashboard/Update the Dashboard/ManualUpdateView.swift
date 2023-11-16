//
//  ManualUpdateView.swift
//  MotoCare
//
//  Created by Nur Hidayatul Fatihah on 13/11/23.
//

import SwiftUI
import SwiftData

struct ManualUpdateView: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var motorcycleVM : MotorcycleViewModel
    
    @Bindable var motorcycle: Motorcycle
    
    @Query(sort: \MaintenanceHistory.date, order: .reverse) var maintenanceHistories: [MaintenanceHistory]
    
//    @Query private var motorcycle: [Motorcycle]
    
    @State private var isModalPresented = false
    @State private var lastServiceMileage = ""
    @State private var selectedSpareparts: [Sparepart] = []
    @FocusState var isInputActive: Bool
    @State private var currentServisSelection: Int = 1
    @State private var isNavigate = false
    
    let availableSpareparts: [Sparepart] = sparepartData
    
    var body: some View {
        NavigationView {
            ZStack{
                BackgroundView()
                VStack {
                    ScrollView {
                        Text("Masukkan data servis terakhir!")
                            .font(.system(size: 18))
                            .frame(width: 355, height: 50, alignment: .topLeading)
                            .foregroundColor(.white)
                        
                        Text("Servis 1")
                            .modifier(ServisTitleModifier())
                        
                        Rectangle()
                            .fill(Color("BackColor"))
                            .cornerRadius(10)
                            .frame(width: 360, height: 40)
                            .overlay(
                                TextField("Jarak tempuh", text: $lastServiceMileage)
                                    .foregroundColor(.primary)
                                    .padding(.horizontal, 20)
                                    .focused($isInputActive)
                                    .toolbar {
                                        ToolbarItemGroup(placement: .keyboard) {
                                            Spacer()
                                        }
                                    }
                                    .keyboardType(.decimalPad)
                            )
                            .padding(.bottom, 5)
                        
                        Button("+ Sparepart") {
                            isModalPresented.toggle()
                            currentServisSelection = 1
                        }
                        .modifier(ButtonStyleModifier())
                        
                        HStack {
                            ForEach(selectedSpareparts, id: \.id) { selectedSparepart in
                                Text(selectedSparepart.name)
                                    .modifier(SelectedSparepartModifier())
                            }
                        }
                    
                        
                        VStack{
                            Button {
                                updateMaintenanceHistory()
                                isNavigate = true
                            } label: {
                                Text("Selesai")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .frame(width: 335, height: 55, alignment: .center)
                                    .background(Color("TabIconColor"))
                                    .cornerRadius(25)
                            }
                        }
                        .padding(.top, 60)
                    }
                    .navigationTitle("Input Manual")
                    .sheet(isPresented: $isModalPresented) {
                        // Pass state isSelectionConfirmed ke SparepartSelectionView
                        SparepartSelectionView(spareparts: availableSpareparts,
                                               selectedSpareparts: $selectedSpareparts,
                                               isModalPresented: $isModalPresented)
                        .presentationDetents([.large, .medium, .fraction(0.40)])
                    }
                    .navigationDestination(isPresented: $isNavigate) {
                        FinishUpdateView()
                    }
                }
            }
        }
    }
    
    
    func updateMaintenanceHistory() {
        // MARK: Save maintenance history
        let maintenanceHistory = MaintenanceHistory(date: Date(),
                                                    maintenanceMileage: Int(lastServiceMileage) ?? 0)
        
        motorcycle.maintenanceHistories.append(maintenanceHistory)
//        print("X: \(maintenanceHistory.date)")
        
        // MARK: Save sparepart history
        for part in selectedSpareparts {
            let sparepart = SparepartHistory(name: part.name, sparepartType: part.type)
//            print("Y: \(maintenanceHistories.first?.date)")
            maintenanceHistories.first?.sparePartHistory.append(sparepart)
        }
        
        print("Success saved!")
    }

}
//
//#Preview {
//    ManualUpdateView()
//}
