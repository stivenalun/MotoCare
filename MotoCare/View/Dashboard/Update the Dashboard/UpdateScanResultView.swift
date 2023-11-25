//
//  UpdateResultView.swift
//  MotoCare
//
//  Created by Anita Saragih on 13/11/23.
//

import SwiftUI
import SwiftData

struct UpdateScanResultView: View {
    @State private var text = ""
    @Binding var extractedUpdatedText1: String?
    @Binding var UpdatescannedServiceMileage: String?
    
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var motorcycleVM : MotorcycleViewModel
    let availableSpareparts: [Sparepart] = sparepartData
    @Bindable var motorcycle: Motorcycle
    @State private var isNavigate = false
    @Query(sort: \MaintenanceHistory.date, order: .reverse) var maintenanceHistories: [MaintenanceHistory]
    @State private var scannedSpareparts: [Sparepart] = []
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Update Selesai!")
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    .frame(width: 355, height: 30, alignment: .topLeading)
                
                Text("Ini dia yang sudah kamu servis.")
                    .font(.system(size: 17))
                    .frame(width: 355, height: 50, alignment: .topLeading)
                
                // Riwayat Servis 1
                VStack(alignment: .leading, spacing: 10) {
                    Text("Servis")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .frame(width: 355, alignment: .topLeading)
                    
                    // Jarak Tempuh
                    HStack {
                        Text("Jarak Tempuh")
                            .font(.body)
                        
                        TextField("xxx kilometer", text: Binding<String>(
                            get: {
                                return UpdatescannedServiceMileage ?? ""
                            },
                            set: { newValue in
                                if let distance = Int(UpdatescannedServiceMileage ?? "") {
                                    let newDistance = distance - 3100
                                    UpdatescannedServiceMileage = String(newDistance)
                                } else {
                                    print("Invalid input")
                                }
                            }
                        ))
                        .foregroundColor(.white)
                        .font(.body)
                        .disabled(true)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                .frame(width: 300, height: 50)
                
                // Perbaikan
                VStack(alignment: .leading, spacing: 10) {
                    Text("Perbaikan")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .frame(width: 355, alignment: .topLeading)
                    
                    HStack{
                        if let extractedText1 = extractedUpdatedText1 {
                            let data = extractedText1.components(separatedBy: ",")
                            
                            ForEach(data, id: \.self) { item in
                                if item != "" {
                                    Text(item)
                                        .foregroundColor(.black)
                                        .padding(10)
                                        .frame(maxWidth: .infinity)
                                        .background(Color(red: 0.12, green: 0.83, blue: 0.91).opacity(0.7))
                                        .cornerRadius(25)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 25)
                                                .inset(by: 0.5)
                                                .stroke(.white, lineWidth: 1)
                                        )
                                }
                            }
                        }
                    } .padding(20)
                }
                .padding(20)
                
                // Tombol Selesai
                Button {
                    ScanUpdateMaintenanceHistory()
                    isNavigate = true
                } label: {
                    Text("Selesai")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: 335, height: 55, alignment: .center)
                        .background(Color("TabIconColor"))
                        .cornerRadius(11)
                }
            }
            .padding()
        }
        .navigationDestination(isPresented: $isNavigate) {
            FinishUpdateView()
        }
    }
    
    func ScanUpdateMaintenanceHistory() {
         let maintenanceHistory = MaintenanceHistory(date: Date(), maintenanceMileage: Int(UpdatescannedServiceMileage ?? "") ?? 0)
//         motorcycle.maintenanceHistories.append(maintenanceHistory)
        // Find the last maintenance history
        if let lastHistory = motorcycle.maintenanceHistories.last {
            // Update the last maintenance history with the new data
            lastHistory.date = maintenanceHistory.date
            lastHistory.maintenanceMileage = maintenanceHistory.maintenanceMileage
        } else {
            // If there is no last maintenance history, append the new one
            motorcycle.maintenanceHistories.append(maintenanceHistory)
        }

        if let extractedUpdateText1 = extractedUpdatedText1 {
                    do {
                        try saveScanSparePartHistory(from: extractedUpdateText1)
                    } catch {
                        print("Error saving spare part history: \(error)")
                    }
                }
         print("Success saved!")
     }
    func saveScanSparePartHistory(from text: String) throws {
        let data = text.components(separatedBy: ",")

        for item in data where item != "" {
            print ("Item: \(item)")

            let lowercaseItem = item.lowercased()
            let sparepartType: SparepartType

            switch lowercaseItem {
            case "airfilter":
                sparepartType = .airfilter
            case "busi":
                sparepartType = .busi
            case "oligardan":
                sparepartType = .oligardan
            case "olimesin":
                sparepartType = .olimesin
            case "vbelt":
                sparepartType = .vbelt
            default:
                // Handle jika jenis sparepart tidak dikenal
                print("Jenis sparepart tidak dikenal: \(item)")
                continue
            }

            let sparepart = SparepartHistory(name: item, sparepartType: sparepartType, maintenanceMileage: motorcycle.maintenanceHistories.last?.maintenanceMileage ?? 0)
//            motorcycle.maintenanceHistories.last?.sparePartHistory.append(sparepart)
            if let lastHistory = motorcycle.maintenanceHistories.last {
                // Append the new sparepart to the last maintenance history
                lastHistory.sparePartHistory.append(sparepart)
            }
        }
    }
    
}

// Preview
//struct UpdateResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpdateResultView(
//            extractedUpdatedText1: .constant(""),
//            extractedUpdatedText2: .constant("")
//        )
//    }
//}
