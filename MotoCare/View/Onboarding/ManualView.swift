//
//  ManualView.swift
//  MotorCareSwiftData
//
//  Created by Nur Hidayatul Fatihah on 31/10/23.
//

import SwiftUI
import SwiftData

struct Xparepart: Identifiable, Equatable { // Conform ke Equatable
    let id = UUID()
    let name: String

    static func == (lhs: Xparepart, rhs: Xparepart) -> Bool {
        return lhs.id == rhs.id
    }
}

struct ManualView: View {
    @Environment(\.modelContext) var modelContext
//    @Query var motorcycles: [Motorcycle]
    
//    @Bindable var motorcycles: Motorcycle
    @EnvironmentObject var motorcycleVM : MotorcycleViewModel
    let motorcycle: Motorcycle
    
    @State private var isModalPresented = false
    @State private var lastServiceMileage = ""
    @State private var selectedSpareparts: [Sparepart] = [] // Menggunakan array untuk mengelola spareparts yang dipilih
    @FocusState var isInputActive: Bool
    @State private var isNavigate = false

    // Dummy data for spareparts
//    let availableSpareparts: [Xparepart] = [
//        Xparepart(name: "Oli Gardan"),
//        Xparepart(name: "Oli Mesin"),
//        Xparepart(name: "V-Belt"),
//        Xparepart(name: "Busi"),
//        Xparepart(name: "Air Filter"),
//    ]
    let availableSpareparts: [Sparepart] = sparepartData
    
//    @State private var s = SparepartHistory()
    
//    private var sparepartDatas : [SparepartData] = [
//        SparepartData(name: "Oli Gardan"),
//        SparepartData(name: "Oli Mesin"),
//        SparepartData(name: "V-Belt"),
//        SparepartData(name: "Busi"),
//        SparepartData(name: "Air Filter")
//    ]

    var body: some View {
        NavigationView {
            VStack {
                ScrollView{
                    Text("Masukkan data servis terakhir!")
                        .font(.system(size: 18))
                        .frame(width: 355, height: 50, alignment: .topLeading)
                    
                    Text("Jarak Tempuh Servis")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .frame(width: 355, alignment: .topLeading)
                    
                    Rectangle()
                        .fill(Color("BackColor"))
                        .cornerRadius(10)
                        .frame(width: 360, height: 40)
                        .overlay(
                            TextField("Jarak Tempuh dalam Kilometer", text: $lastServiceMileage)
                                .foregroundColor(.primary)
                                .padding(.horizontal, 20)
                                .focused($isInputActive)
                                .toolbar {
                                    ToolbarItemGroup(placement: .keyboard) {
                                        Spacer()
                                        
                                        Button("Done") {
                                            isInputActive = false
                                        }
                                    }
                                }
                        )
//                        .padding(.horizontal)
                        .padding(.bottom, 15)
                    
                    VStack{
                        Text("Perbaikan")
                            .font(.callout)
                            .fontWeight(.bold)
                            .frame(width: 355, alignment: .topLeading)
                            .padding(.bottom, 8)
                        Button("+ Sparepart") {
                            isModalPresented.toggle()
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                        .foregroundColor(.black)
                        .background(Color("TabIconColor"))
                        .cornerRadius(8)
                        .padding(.trailing, 230)
                    }
                    HStack {
                        ForEach(selectedSpareparts, id: \.id) { selectedSparepart in
                            Text(selectedSparepart.name)
                                .foregroundColor(.black)
                                .padding(10)
                                .background(Color(red: 1, green: 0.94, blue: 0.71))
                                .cornerRadius(25)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .inset(by: 0.5)
                                        .stroke(.white, lineWidth: 1)
                                )
                        }
                    }
                    
                    VStack{
                        Button {
                            //hajar aja buat save data
//                            let selectedSparepartsNames = selectedSpareparts.map { \$0.name }
//                                let serviceData = MaintenanceHistory(lastServiceMileage: lastServiceMileage, selectedSpareparts: selectedSparepartsNames)
//                                modelContext.insert(serviceData)
//                                do {
//                                    try modelContext.save()
//                                    isNavigate = true
//                                } catch {
//                                    print(error.localizedDescription)
//                                }
                            
                            addSpareparts()
                            isNavigate = true
                            
                        } label: {
                            Text("Selesai")
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(width: 335, height: 55, alignment: .center)
                                .background(Color(red: 1, green: 0.83, blue: 0.15))
                                .cornerRadius(25)
                        }
                    }
                    .padding(.top, 280)
                }
                .navigationTitle("Input Manual")
                .sheet(isPresented: $isModalPresented) {
                    // Pass state isSelectionConfirmed ke SparepartSelectionView
                    SparepartSelectionView(spareparts: availableSpareparts, selectedSpareparts: $selectedSpareparts, isModalPresented: $isModalPresented)
                        .presentationDetents([.large, .medium, .fraction(0.45)])
                }
                .navigationDestination(isPresented: $isNavigate) {
                    FinishOnboardingView()
                }
            }
        }
    }
    
    func addSpareparts() {
        for part in selectedSpareparts {
            let sparepart = SparepartHistory(name: part.name, lastServiceMileage: Int(lastServiceMileage)!, sparepartType: part.type)
//            motorcycleVM.motorcycle.spareparts?.append(sparepart)
            sparepart.motorcycle = motorcycle
            motorcycle.spareparts?.append(sparepart)
        }
    }
}

struct SparepartSelectionView: View {
    var spareparts: [Sparepart]
    @Binding var selectedSpareparts: [Sparepart]
    @Binding var isModalPresented: Bool

    var body: some View {
        NavigationView {
            List(spareparts) { sparepart in
                Button(action: {
                    if selectedSpareparts.contains(sparepart) {
                        selectedSpareparts.removeAll { $0 == sparepart }
                    } else {
                        selectedSpareparts.append(sparepart)
                    }
                }) {
                    HStack {
                        Text(sparepart.name)
                        Spacer()
                        if selectedSpareparts.contains(sparepart) {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isModalPresented = false // Tutup modal saat "Konfirmasi" diklik
                    }
                }
            }
        }
    }
}


//#Preview {
//    ManualView()
//}
