//
//  ManualView2.swift
//  MotoCare
//
//  Created by Stiven on 08/11/23.
//

import SwiftUI

struct ManualView2: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var motorcycleVM : MotorcycleViewModel
    @Bindable var motorcycle: Motorcycle
    @State private var lastServiceMileage = ""
    @FocusState var isInputActive: Bool
    @State private var isPushed: Bool = false
    
    @State private var selectedSpareparts: [Sparepart] = []
    
    var body: some View {
        NavigationView {
            ZStack{
                BackgroundView()
                VStack {
                    VStack {
                        ScrollView(showsIndicators: false) {
                            VStack(alignment: .leading) {
                                Text("Yuk input sampai 3 perbaikan terakhirmu di bengkel.")
                                    .font(.system(size: 17))
                                    .foregroundColor(.white)
                                    .padding(.bottom, 20)
                                    .frame(maxWidth: 350, alignment: .topLeading)
                                
                                Text("Riwayat Servis 1")
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.white)
                                
                                Rectangle()
                                    .fill(Color("BackColor"))
                                    .cornerRadius(10)
                                    .frame(width: 350, height: 35)
                                    .overlay(
                                        TextField("Jarak tempuh", text: $lastServiceMileage)
                                            .foregroundColor(.primary)
                                            .padding(.horizontal, 10)
                                            .keyboardType(.numberPad)
                                            .focused($isInputActive)
                                            .toolbar {
                                                ToolbarItemGroup(placement: .keyboard) {
                                                    Spacer()
                                                    Button("Done"){
                                                        isInputActive = false
                                                    }
                                                }
                                            }
                                    )
                                
                                Text ("Sparepart yang diservis")
                                    .padding(.top, 2)
                                    .foregroundColor(.white)
                                VStack{
                                    HStack(spacing:15){
                                        RectangleStyle()
                                            .frame(width: 120, height: 30)
                                            .overlay(
                                                CheckboxField(
                                                    partData: sparepartData[4],
                                                    callback: checkboxSelected
                                                )
                                            )
                                        RectangleStyle()
                                            .frame(width: 115, height: 30)
                                            .overlay(
                                                CheckboxField(
                                                    partData: sparepartData[0],
                                                    callback: checkboxSelected
                                                )
                                            )
                                        Spacer()
                                    } .padding(.horizontal, 5)
                                    
                                    HStack(spacing:15){
                                        RectangleStyle()
                                            .frame(width: 130, height: 30)
                                            .overlay(
                                                CheckboxField(
                                                    partData: sparepartData[1],
                                                    callback: checkboxSelected
                                                )
                                            )
                                        RectangleStyle()
                                            .frame(width: 145, height: 30)
                                            .overlay(
                                                CheckboxField(
                                                    partData: sparepartData[3],
                                                    callback: checkboxSelected
                                                )
                                            )
                                        Spacer()
                                    } .padding(.horizontal, 5)
                                    
                                    HStack(spacing:15){
                                        RectangleStyle()
                                            .frame(width: 140, height: 30)
                                            .overlay(
                                                CheckboxField(
                                                    partData: sparepartData[2],
                                                    callback: checkboxSelected
                                                )
                                            )
                                        Spacer()
                                    } .padding(.horizontal, 5)
                                }
                            }
                            .padding()
                            .navigationBarTitle("Manual Input")
                        }
                    }
                    
                    NavigationLink(
                        destination: FinishOnboardingView(),
                        isActive: $isPushed,
                        label: {
                            Button(action: {
                                print("===================================")
                                addMaintenanceHistory()
                                isPushed.toggle()
                            }, label: {
                                Text("Selesai")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .frame(width: 335, height: 45)
                                    .background(Color(red: 0.12, green: 0.83, blue: 0.91))
                                    .cornerRadius(11)
                            })
                        })
                    
                    
                }
            }
        }
    }
    
    func checkboxSelected(sparepart: Sparepart, isMarked: Bool) {
        print("\(sparepart) is marked: \(isMarked)")
        //
        if isMarked {
            // If marked, add to the selectedSpareparts array
            selectedSpareparts.append(sparepart)
        } else {
            // If unmarked, remove from the selectedSpareparts array
            if let index = selectedSpareparts.firstIndex(of: sparepart) {
                selectedSpareparts.remove(at: index)
            }
        }
        //
    }
    
    func addMaintenanceHistory() {
        // MARK: Save maintenance history
        let maintenanceHistory = MaintenanceHistory(date: Date(),
                                                    maintenanceMileage: Int(lastServiceMileage) ?? 0)
        
        motorcycle.maintenanceHistories.append(maintenanceHistory)
        
        for part in selectedSpareparts {
            let sparepart = SparepartHistory(name: part.type.rawValue, sparepartType: part.type)
            motorcycle.maintenanceHistories.last?.sparePartHistory.append(sparepart)
        }
        
        
        print("Success saved!")
    }
    
    struct RectangleStyle: View {
        var body: some View {
            Rectangle()
                .foregroundColor(Color(red: 0.12, green: 0.83, blue: 0.91).opacity(0.7))
                .cornerRadius(10)
                .padding(.leading, -4)
        }
    }
    
}

//MARK:- Checkbox Field
struct CheckboxField: View {
    
    let partData: Sparepart
    let size: CGFloat
    let color: Color
    let textSize: Int
    let callback: (Sparepart, Bool)->()
    
    init(
        partData: Sparepart,
        color: Color = Color.white,
        callback: @escaping (Sparepart, Bool)->()
    ) {
        self.partData = partData
        self.size = 17
        self.color = color
        self.textSize = 17
        self.callback = callback
    }
    
    @State var isMarked:Bool = false
    
    var body: some View {
        Button(action:{
            self.isMarked.toggle()
            self.callback(partData, self.isMarked)
        }) {
            HStack(alignment: .center, spacing: 6) {
                Image(systemName: self.isMarked ? "checkmark.circle.fill" : "circle")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                Image(partData.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                Text(partData.type.rawValue)
                    .font(Font.system(size: size))
                Spacer()
            }.foregroundColor(self.color)
        }
        .foregroundColor(Color.white)
    }
}



//#Preview {
//    ManualView2()
//}


//#Preview {
//    ManualView2(motorcycle: motorcycleVM.motorcycle)
//}

