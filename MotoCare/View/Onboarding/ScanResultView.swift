import SwiftUI
import SwiftData

struct ScanResultView: View {
    @State private var text = ""
    @Binding var extractedText1: String?
    @Binding var scannedServiceMileage: String?
    @Binding var extractedText3: String?
    @Binding var extractedText4: String?
    @Binding var extractedText5: String?
    @Binding var extractedText6: String?
    
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var motorcycleVM : MotorcycleViewModel
    let availableSpareparts: [Sparepart] = sparepartData
    @Bindable var motorcycle: Motorcycle
    @State private var isNavigate = false
//    var date: Date
//    var maintenanceMileage: Int
    @State private var scannedSpareparts: [Sparepart] = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Hampir Selesai!")
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    .frame(width: 355, height: 30, alignment: .topLeading)
                
                Text("Ini nih hasil scan riwayat servismu.")
                    .font(.system(size: 17))
                    .frame(width: 355, height: 50, alignment: .topLeading)
                
                // Riwayat Servis 1
                VStack(alignment: .leading, spacing: 10) {
                    Text("Servis 1")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .frame(width: 355, alignment: .topLeading)
                    
                    // Jarak Tempuh
                    HStack {
                        Text("Jarak Tempuh")
                            .font(.body)
                        
                        TextField("xxx kilometer", text: Binding<String>(
                            get: {
                                return scannedServiceMileage ?? ""
                            },
                            set: { newValue in
                                if let distance = Int(scannedServiceMileage ?? "") {
                                   let newDistance = distance - 3100
                                   scannedServiceMileage = String(newDistance)
                                } else {
                                   print("Invalid input")
                                }
                            }
                        ))
                        .foregroundColor(.white)
                        .font(.body)
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
                        if let extractedText1 = extractedText1 {
                            let data = extractedText1.components(separatedBy: ",")
                            
                            ForEach(data, id: \.self) { item in
                                
                                if item != "" {
                                    Text(item)
                                        .foregroundColor(.black)
                                        .padding(10)
                                        .frame(maxWidth: .infinity)
                                        .background(Color(red: 1, green: 0.94, blue: 0.71))
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
                
                // Riwayat Servis 2
                VStack(alignment: .leading, spacing: 10) {
                    Text("Servis 2")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .frame(width: 355, alignment: .topLeading)
                    
                    // Jarak Tempuh
                    HStack {
                        Text("Jarak Tempuh")
                            .font(.body)
                        
                        TextField("xxx kilometer", text: Binding<String>(
                            get: {
                                return extractedText4 ?? ""
                            },
                            set: { newValue in
                                if let distance = Int(extractedText4 ?? "") {
                                   let newDistance = distance - 3100
                                   extractedText4 = String(newDistance)
                                } else {
                                   print("Invalid input")
                                }
                            }
                        ))
                        .foregroundColor(.white)
                        .font(.body)
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
                        if let extractedText3 = extractedText3 {
                            let data = extractedText3.components(separatedBy: ",")
                            
                            ForEach(data, id: \.self) { item in
                                if item != "" {
                                    Text(item)
                                        .foregroundColor(.black)
                                        .padding(10)
                                        .frame(maxWidth: .infinity)
                                        .background(Color(red: 1, green: 0.94, blue: 0.71))
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
                
                // Riwayat Servis 3
                VStack(alignment: .leading, spacing: 10) {
                    Text("Servis 3")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .frame(width: 355, alignment: .topLeading)
                    
                    // Jarak Tempuh
                    HStack {
                        Text("Jarak Tempuh")
                            .font(.body)
                        
                        TextField("xxx kilometer", text: Binding<String>(
                            get: {
                                return extractedText6 ?? ""
                            },
                            set: { newValue in
                                if let distance = Int(extractedText6 ?? "") {
                                   let newDistance = distance - 3100
                                   extractedText6 = String(newDistance)
                                } else {
                                   print("Invalid input")
                                }
                            }
                        ))
                        .foregroundColor(.white)
                        .font(.body)
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
                        if let extractedText5 = extractedText5 {
                            let data = extractedText5.components(separatedBy: ",")
                            
                            ForEach(data, id: \.self) { item in
                                if item != "" {
                                    Text(item)
                                        .foregroundColor(.black)
                                        .padding(10)
                                        .frame(maxWidth: .infinity)
                                        .background(Color(red: 1, green: 0.94, blue: 0.71))
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
                    addMaintenanceHistory()
                    isNavigate = true
                } label: {
                    Text("Selesai")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: 335, height: 55, alignment: .center)
                        .background(Color("TabIconColor"))
                        .cornerRadius(25)
                }
//                NavigationLink(destination: FinishOnboardingView()) {
//                                  Text("Selesai")
//                                      .font(.headline)
//                                      .foregroundColor(.black)
//                                      .frame(width: 335, height: 55)
//                                      .background(Color(red: 1, green: 0.83, blue: 0.15))
//                                      .cornerRadius(25)
//                                      .onTapGesture {
//                                          addMaintenanceHistory()
//                                          
//                                      }
//                    }
            }
            .padding()
        }
        .navigationDestination(isPresented: $isNavigate) {
            FinishOnboardingView()
        }
    }
    
   func addMaintenanceHistory() {
        // MARK: Save maintenance history
        let maintenanceHistory = MaintenanceHistory(date: Date(), maintenanceMileage: Int(scannedServiceMileage ?? "") ?? 0)
        motorcycle.maintenanceHistories.append(maintenanceHistory)
       
       if let extractedText1 = extractedText1 {
                   do {
                       try saveSparePartHistory(from: extractedText1)
                   } catch {
                       print("Error saving spare part history: \(error)")
                   }
               }

//        if let extractedText1 = extractedText1 {
//            try saveSparePartHistory(from: extractedText1)
//        }
//        if let extractedText3 = extractedText3 {
//            saveSparePartHistory(from: extractedText3)
//        }
//        if let extractedText5 = extractedText5 {
//            saveSparePartHistory(from: extractedText5)
//        }

        print("Success saved!")
    }
    
    func saveSparePartHistory(from text: String) throws {
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

            let sparepart = SparepartHistory(name: item, sparepartType: sparepartType)
            motorcycle.maintenanceHistories.last?.sparePartHistory.append(sparepart)
        }
    }

    
//    func saveSparePartHistory(from text: String) throws {
//       let data = text.components(separatedBy: ",")
//
//       for item in data where item != "" {
//           print ("Item: \(item)")
//           let sparepartType: SparepartType
//           switch item {
//           case "Air Filter":
//               sparepartType = .airfilter
//           case "Busi":
//               sparepartType = .busi
//           case "Oli Gardan":
//               sparepartType = .oligardan
//           case "Oli Mesin":
//               sparepartType = .olimesin
//           case "V-Belt":
//               sparepartType = .vbelt
//           // tambahkan case lainnya di sini untuk jenis sparepart lainnya
//           default:
//               sparepartType = .vbelt // default jika jenis sparepart tidak dikenal
//           }
//           let sparepart = SparepartHistory(name: item, sparepartType: sparepartType)
//           motorcycle.maintenanceHistories.last?.sparePartHistory.append(sparepart)
//       }
//    }

    
//    func saveSparePartHistory(from text: String) {
//            let data = text.components(separatedBy: ",")
//
//            for item in data where item != "" {
//                let sparepart = SparepartHistory(name: item, sparepartType: .olimesin)
//                motorcycle.maintenanceHistories.last?.sparePartHistory.append(sparepart)
//            }
//        }
    
//    func addMaintenanceHistory() {
//        // MARK: Save maintenance history
//        let maintenanceHistory = MaintenanceHistory(date: Date(),
//                                                    maintenanceMileage: Int(scannedServiceMileage ?? "") ?? 0)
//        
//        motorcycle.maintenanceHistories.append(maintenanceHistory)
//        
//        // MARK: Save sparepart history
//        for part in selectedSpareparts {
//            let sparepart = SparepartHistory(name: part.name, sparepartType: part.type)
//            motorcycle.maintenanceHistories.last?.sparePartHistory.append(sparepart)
//        }
//        
//        print("Success saved!")
//    }
}

// Preview
//struct ScanResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScanResultView(
//            extractedText1: .constant(""),
//            extractedText2: .constant(""),
//            extractedText3: .constant(""),
//            extractedText4: .constant(""),
//            extractedText5: .constant(""),
//            extractedText6: .constant("")
//        )
//    }
//}

