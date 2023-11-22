//
//  ManualUpdateView.swift
//  MotoCare
//
//  Created by Nur Hidayatul Fatihah on 13/11/23.


import SwiftUI
import SwiftData

struct ManualUpdateView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var motorcycleVM : MotorcycleViewModel
    
    @Bindable var motorcycle: Motorcycle
    
    @Query(sort: \MaintenanceHistory.date, order: .reverse) var maintenanceHistories: [MaintenanceHistory]
    
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
                        
                        Text("Servis")
                            .modifier(ServisTitleModifier())
                        
                        Rectangle()
                            .fill(Color.gray.opacity(0.7))
                            .cornerRadius(10)
                            .frame(width: 350, height: 35)
                            .overlay(
                                TextField("Jarak tempuh", text: $lastServiceMileage)
                                    .foregroundColor(.primary)
                                    .padding(.horizontal, 10)
                                    .keyboardType(.numberPad)
                            )
                        
                        Text("Sparepart")
                            .padding(.top, 2)
                            .foregroundColor(.white)
                        VStack {
                            HStack{
                                UpdateCheckboxRow(sparepart: sparepartData[0], selectedSpareparts: $selectedSpareparts)
                                UpdateCheckboxRow(sparepart: sparepartData[1], selectedSpareparts: $selectedSpareparts)
                            }
                            HStack{
                                UpdateCheckboxRow(sparepart: sparepartData[2], selectedSpareparts: $selectedSpareparts)
                                UpdateCheckboxRow(sparepart: sparepartData[3], selectedSpareparts: $selectedSpareparts)
                            }
                            HStack{
                                UpdateCheckboxRow(sparepart: sparepartData[4], selectedSpareparts: $selectedSpareparts)
                                    .padding(.leading, -145)
                            }
                            
                            // Add more CheckboxRows as needed
                        }
                    
                        
                        VStack{
                            Button {
                                updateMaintenanceHistory()
                                isNavigate = true
                            } label: {
                                Text("Tambahkan")
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
    func UpdatecheckboxSelected(sparepart: Sparepart, isMarked: Bool) {
        handleCheckboxSelection(sparepart: sparepart, isMarked: isMarked, selectedSpareparts: $selectedSpareparts)
    }
    
    private func handleCheckboxSelection(sparepart: Sparepart, isMarked: Bool, selectedSpareparts: Binding<[Sparepart]>) {
        if isMarked {
            selectedSpareparts.wrappedValue.append(sparepart)
        } else {
            if let index = selectedSpareparts.wrappedValue.firstIndex(of: sparepart) {
                selectedSpareparts.wrappedValue.remove(at: index)
            }
        }
    }
    
    func updateMaintenanceHistory() {
       let maintenanceHistory = MaintenanceHistory(date: Date(),
                                               maintenanceMileage: Int(lastServiceMileage) ?? 0)
       if let lastHistory = motorcycle.maintenanceHistories.last {
           lastHistory.date = maintenanceHistory.date
           lastHistory.maintenanceMileage = maintenanceHistory.maintenanceMileage
       } else {
           motorcycle.maintenanceHistories.append(maintenanceHistory)
       }
       // MARK: Save sparepart history
       for part in selectedSpareparts {
           let sparepart = SparepartHistory(name: part.type.rawValue, sparepartType: part.type)
           if let lastHistory = motorcycle.maintenanceHistories.last {
               lastHistory.sparePartHistory.append(sparepart)
           }
       }
       print("Success saved!")
    }
    
    private func appendSparepartsToMaintenanceHistory(selectedSpareparts: [Sparepart]) {
        for part in selectedSpareparts {
            let sparepart = SparepartHistory(name: part.name, sparepartType: part.type)
            motorcycle.maintenanceHistories.last?.sparePartHistory.append(sparepart)
        }
    }
}

struct UpdateCheckboxRow: View {
    let sparepart: Sparepart
    @Binding var selectedSpareparts: [Sparepart]

    var body: some View {
        Rectangle()
            .foregroundColor(Color(red: 0.12, green: 0.83, blue: 0.91).opacity(0.7))
            .frame(width: 145, height: 30)
            .cornerRadius(10)
            .padding(.leading, -4)
            .overlay(
                UpdateCheckboxField(
                    sparepart: sparepart,
                    label: sparepart,
                    size: 17,
                    textSize: 17,
                    imageName: sparepart.icon,
                    callback: { isMarked in
                        handleCheckboxSelection(sparepart: sparepart, isMarked: isMarked, selectedSpareparts: $selectedSpareparts)
                    }
                )
            )
    }

    private func handleCheckboxSelection(sparepart: Sparepart, isMarked: Bool, selectedSpareparts: Binding<[Sparepart]>) {
        if isMarked {
            selectedSpareparts.wrappedValue.append(sparepart)
        } else {
            if let index = selectedSpareparts.wrappedValue.firstIndex(of: sparepart) {
                selectedSpareparts.wrappedValue.remove(at: index)
            }
        }
    }
}

struct UpdateCheckboxField: View {
    let id: Sparepart
    let label: Sparepart
    let size: CGFloat
    let color: Color
    let textSize: Int
    let imageName: String
    let callback: (Bool)->()

    init(
        sparepart: Sparepart,
        label: Sparepart,
        size: CGFloat = 10,
        color: Color = Color.white,
        textSize: Int = 14,
        imageName: String,
        callback: @escaping (Bool)->()
    ) {
        self.id = sparepart
        self.label = sparepart
        self.size = size
        self.color = color
        self.textSize = textSize
        self.imageName = sparepart.icon
        self.callback = callback
    }

    @State var isMarked: Bool = false

    var body: some View {
        Button(action: {
            self.isMarked.toggle()
            self.callback(self.isMarked)
        }) {
            HStack(alignment: .center, spacing: 6) {
                Image(systemName: self.isMarked ? "checkmark.circle.fill" : "circle")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                Image(self.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                Text(label.name)
                    .font(Font.system(size: size))
                Spacer()
            }.foregroundColor(self.color)
        }
        .foregroundColor(Color.white)
    }
}


