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
                Spacer()
                Image("odometer")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 328, height: 187)
                    .padding(.horizontal, 18)
                    .padding(.top, -25)
                    
                Text("Perbarui jarak tempuh motormu saat ini")
                    .font(.system(size: 28))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 15)
                    .fontWeight(.bold)
                    .frame(width: 380, alignment: .topLeading)
                
                Text("Cek odometer untuk mengetahui jarak tempuh kamu yang terkini. Kondisi spare-part-mu akan kami ukur berdasarkan ini.")
                    .padding(.horizontal, 20)
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .frame(width: 380, alignment: .topLeading)
                    .padding(.bottom, 15)
                
                HStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.7))
                        .cornerRadius(10)
                        .frame(width: 345, height: 35)
                        .overlay(
                            TextField("Masukan jarak tempuhmu saat ini", text: $currentMileage)
                                .foregroundColor(.primary)
                                .padding(.horizontal, 10)
                                .keyboardType(.numberPad)
                            )
                }
                .frame(width: 390, height: 30)
                Spacer()
                Spacer()
            }
            VStack{
                Spacer()
                Button(action: {
                    editMotorcycle()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Simpan")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: 345, height: 45)
                        .background(Color("TabIconColor"))
                        .cornerRadius(11)
                }
//                    .padding(.top, 65)
            }
            .padding(.bottom, 30)
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
