//
//  ModalOdometerView.swift
//  MotorCareSwiftData
//
//  Created by Nur Hidayatul Fatihah on 31/10/23.
//

import SwiftUI
import SwiftData

struct ModalUpdateOdometerView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var motorcycleVM : MotorcycleViewModel
    
    @Query var motorcycles: [Motorcycle]
    
    @State var motorcycle: Motorcycle = Motorcycle()
    @State private var selectedSpareparts: [Sparepart] = []
    @State private var currentMileage: String = ""
    
    var isTextFieldEmpty: Bool {
        return currentMileage.isEmpty
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                LottiePlusView(name: Constants.done, loopMode: .loop, animationSpeed: 0.25,  contentMode: .scaleAspectFit)
                    .frame(width: 200, height: 300)
                
                Text("Jarak tempuh motormu\nsudah sampai mana ya?")
                    .font(.system(size: 28))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 15)
                    .fontWeight(.bold)
                    .frame(width: 355)
                
                Text("Cek odometer untuk mengetahui jarak tempuh kamu yang terkini. Kondisi spare-part-mu akan kami ukur berdasarkan ini.")
                    .padding(.horizontal, 20)
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .frame(width: 355, alignment: .topLeading)
                
                HStack {
                    TextField("Perbarui jarak tempuhmu", text: $currentMileage)
                        .foregroundColor(.primary)
                        .background(Color("BackColor").cornerRadius(8))
                        .font(.system(size: 22))
                        .padding(.horizontal, 38)
                        .padding(.top, 40)
                        .keyboardType(.numberPad)
                }
                .frame(width: 390, height: 30)
                
                VStack{
                    Button(action: {
                        editMotorcycle()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Simpan")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(width: 335, height: 55)
                            .background(Color("TabIconColor"))
                            .cornerRadius(25)
                    }
                    .padding(.top, 65)
                }
            }
        }
    }
    func editMotorcycle() {
        motorcycles[0].currentMileage = Int(currentMileage) ?? 0
        print("save success")
    }

}

#Preview {
    ModalUpdateOdometerView()
}
