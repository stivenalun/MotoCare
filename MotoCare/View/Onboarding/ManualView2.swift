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

    let motorcycle: Motorcycle
    
    @State private var lastServiceMileage = ""
    @FocusState var isInputActive: Bool
    

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
                                        Rectangle()
                                            .foregroundColor(Color(red: 0.12, green: 0.83, blue: 0.91).opacity(0.7))
                                            .frame(width: 120, height: 30)
    
                                            .cornerRadius(10)
                                            .padding(.leading, -4)
                                            .overlay(
                                                CheckboxField(
                                                    id: Part.vbelt.rawValue,
                                                    label: Part.vbelt.rawValue,
                                                    size: 17,
                                                    textSize: 17,
                                                    imageName: "v-belt",
                                                    callback: checkboxSelected
                                                )
                                            )
                                        Rectangle()
                                            .foregroundColor(Color(red: 0.12, green: 0.83, blue: 0.91).opacity(0.7))
                                            .frame(width: 115, height: 30)
                                            .cornerRadius(10)
                                            .padding(.leading, -4)
                                            .overlay(
                                                CheckboxField(
                                                    id: Part.busi.rawValue,
                                                    label: Part.busi.rawValue,
                                                    size: 17,
                                                    textSize: 17,
                                                    imageName: "spark-plug",
                                                    callback: checkboxSelected
                                                )
                                            )
                                        Spacer()
                                    } .padding(.horizontal, 5)
                                    
                                    HStack(spacing:15){
                                        Rectangle()
                                            .foregroundColor(Color(red: 0.12, green: 0.83, blue: 0.91).opacity(0.7))
                                            .frame(width: 130, height: 30)
                                            .cornerRadius(10)
                                            .padding(.leading, -4)
                                            .overlay(
                                                CheckboxField(
                                                    id: Part.airfilter.rawValue,
                                                    label: Part.airfilter.rawValue,
                                                    size: 17,
                                                    textSize: 17,
                                                    imageName: "air-filter",
                                                    callback: checkboxSelected
                                                )
                                            )
                                        Rectangle()
                                            .foregroundColor(Color(red: 0.12, green: 0.83, blue: 0.91).opacity(0.7))
                                            .frame(width: 145, height: 30)
                                            .cornerRadius(10)
                                            .padding(.leading, -4)
                                            .overlay(
                                                CheckboxField(
                                                    id: Part.oligardan.rawValue,
                                                    label: Part.oligardan.rawValue,
                                                    size: 17,
                                                    textSize: 17,
                                                    imageName: "final-drive-oil",
                                                    callback: checkboxSelected
                                                )
                                            )
                                        Spacer()
                                    } .padding(.horizontal, 5)
                                    
                                    HStack(spacing:15){
                                        Rectangle()
                                            .foregroundColor(Color(red: 0.12, green: 0.83, blue: 0.91).opacity(0.7))
                                            .frame(width: 140, height: 30)
                                            .cornerRadius(10)
                                            .padding(.leading, -4)
                                            .overlay(
                                                CheckboxField(
                                                    id: Part.olimesin.rawValue,
                                                    label: Part.olimesin.rawValue,
                                                    size: 17,
                                                    textSize: 17,
                                                    imageName: "engine-oil",
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
                    NavigationLink(destination: FinishOnboardingView()) {
                        Text("Selesai")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(width: 335, height: 45)
                            .background(Color(red: 0.12, green: 0.83, blue: 0.91))
                            .cornerRadius(11)
                    }
                }
            }
        }
    }
    func checkboxSelected(id: String, isMarked: Bool) {
            print("\(id) is marked: \(isMarked)")
        }
}

//MARK:- Checkbox Field
struct CheckboxField: View {
    let id: String
    let label: String
    let size: CGFloat
    let color: Color
    let textSize: Int
    let imageName: String
    let callback: (String, Bool)->()
    
    init(
        id: String,
        label:String,
        size: CGFloat = 10,
        color: Color = Color.white,
        textSize: Int = 14,
        imageName: String,
        callback: @escaping (String, Bool)->()
    ) {
        self.id = id
        self.label = label
        self.size = size
        self.color = color
        self.textSize = textSize
        self.imageName = imageName
        self.callback = callback
    }
    
    @State var isMarked:Bool = false
    
    var body: some View {
        Button(action:{
            self.isMarked.toggle()
            self.callback(self.id, self.isMarked)
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
                Text(label)
                    .font(Font.system(size: size))
                Spacer()
            }.foregroundColor(self.color)
        }
        .foregroundColor(Color.white)
    }
}

enum Part: String {
    case vbelt = "V-Belt"
    case busi = "Busi"
    case olimesin = "Oli Mesin"
    case airfilter = "Air Filter"
    case oligardan = "Oli Gardan"
}
    
    
//#Preview {
//    ManualView2()
//}
    
    
//#Preview {
//    ManualView2(motorcycle: motorcycleVM.motorcycle)
//}

