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
    @EnvironmentObject var motorcycleVM : MotorcycleViewModel
    @State var motorcycle: Motorcycle = Motorcycle()
    @State private var currentMileage: String = ""
    @State private var isShowingInputLastReceiptView = false

    
    var isTextFieldEmpty: Bool {
        return currentMileage.isEmpty
    }
    
    var body: some View {
        ZStack{
            BackgroundView()
            VStack {
                Spacer()
                Image("odometer")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 324, height: 169)
                    .padding(.horizontal, 18)
                    .padding(.top, 10)
                
                Text("Jarak tempuh motormu sudah sampai mana ya?")
                    .font(.system(size: 33))
                    .foregroundColor(.white)
                    .padding(.top, 30)
                    .padding(.bottom, 10)
                    .fontWeight(.bold)
                    .frame(maxWidth: 345, alignment: .topLeading)
                
                Text("Ketahui kondisi part motor Anda dari jarak tempuh yang tertera di odometer.")
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .frame(maxWidth: 345, alignment: .topLeading)
                    .padding(.bottom, 30)
                    .padding(.top, 5)
                
                Rectangle()
                    .fill(Color.gray.opacity(0.7))
                    .cornerRadius(10)
                    .frame(width: 345, height: 35)
                    .overlay(
                        TextField("Masukan jarak tempuhmu saat ini", text: $currentMileage)
                            .foregroundColor(.primary)
                            .padding(.horizontal, 10)
                            .keyboardType(.numberPad)
                            .onChange(of: currentMileage) {
                                // Limit the character input to 6 digits
                                if currentMileage.count > 6 {
                                    currentMileage = String(currentMileage.prefix(6))
                                }
                            }
                    )
                
                Spacer()
                
                Button(action: {
                    saveMotorcycle()
                    isShowingInputLastReceiptView.toggle()
                }) {
                    Text("Lanjutkan")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: 345, height: 45)
                        .background(Color(red: 0.12, green: 0.83, blue: 0.91))
                        .cornerRadius(11)
                }
                .padding(.bottom, 30)
                .disabled(isTextFieldEmpty)
            }
            .navigationDestination(isPresented: $isShowingInputLastReceiptView) {
                InputLastReceiptsView(motorcycle: motorcycle)
            }
        }
    }
    
    func saveMotorcycle() {
        motorcycle = Motorcycle(brand: "Lexi", currentMileage: Int(currentMileage) ?? 0)
        modelContext.insert(motorcycle)
        print("save success")
//        path = [motorcycle]
    }
}

#Preview {
    InputOdometerView(motorcycle: Motorcycle())
}
