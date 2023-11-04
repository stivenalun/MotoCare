//
//  InputOdometerView.swift
//  MotorCareSwiftData
//
//  Created by Nur Hidayatul Fatihah on 31/10/23.
//

import SwiftUI
import SwiftData

struct InputOdometerView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var currentMileage: String = ""
    @State private var isShowingInputLastReceiptView = false
    
    var isTextFieldEmpty: Bool {
        return currentMileage.isEmpty
    }
    
    var body: some View {
        VStack {
            Image("odometer")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 45)
            
            Text("Jarak tempuh motormu\nsudah sampai mana ya?")
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
                TextField("Masukan jarak tempuhmu", text: $currentMileage)
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
                    let motorcycle = Motorcycle(id_motorcycle: UUID(), currentMileage: Int(currentMileage) ?? 0, sparePartsData: [])
                    
                        modelContext.insert(motorcycle)
                   
                    do {
                       try modelContext.save()
                       if !isTextFieldEmpty {
                           isShowingInputLastReceiptView.toggle()
                       }
                        
                   } catch {
                       print(error.localizedDescription)
                   }
                }) {
                   Text("Lanjutkan")
                       .font(.headline)
                       .foregroundColor(.black)
                       .frame(width: 335, height: 55)
                       .background(Color(red: 1, green: 0.83, blue: 0.15))
                       .cornerRadius(25)
                }
                .padding(.top, 65)
                .disabled(isTextFieldEmpty)
            }
        }
        .navigationDestination(isPresented: $isShowingInputLastReceiptView) {
            InputLastReceiptsView()
        }
    }
}

#Preview {
    InputOdometerView()
}
