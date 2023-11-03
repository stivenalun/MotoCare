//
//  ModalOdometerView.swift
//  MotorCareSwiftData
//
//  Created by Nur Hidayatul Fatihah on 31/10/23.
//

import SwiftUI
import SwiftData

struct ModalOdometerView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.presentationMode) var presentationMode
    @Query var motorcycles: [Motorcycle]
    
    @State private var currentMileage: String = ""
    
    var body: some View {
        VStack {
            Image("odometer")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 45)
            
            Text("Waktunya perbarui \njarak tempuh motormu.")
                .font(.system(size: 28))
                .padding(.horizontal, 20)
                .padding(.bottom, 15)
                .fontWeight(.bold)
                .frame(width: 355)
            
            Text("Cek odometer untuk mengetahui jarak tempuh kamu yang terkini. Kondisi spare-part-mu akan kami ukur berdasarkan ini.")
                .padding(.horizontal, 20)
                .font(.system(size: 17))
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
                    if let motorcycle = motorcycles.first {
                        motorcycle.currentMileage = Int(currentMileage) ?? 0
                        do {
                            try modelContext.save()
                            presentationMode.wrappedValue.dismiss()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }) {
                   Text("Simpan")
                       .font(.headline)
                       .foregroundColor(.black)
                       .frame(width: 335, height: 55)
                       .background(Color(red: 1, green: 0.83, blue: 0.15))
                       .cornerRadius(25)
                }
                .padding(.top, 65)
            }
        }
    }
}

#Preview {
    ModalOdometerView()
}
