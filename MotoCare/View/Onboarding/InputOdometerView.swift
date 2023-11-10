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
    
    @Query private var motorcycle: [Motorcycle]
    
    @State private var currentMileage: String = ""
    @State private var isShowingInputLastReceiptView = false
    @FocusState var isInputActive: Bool
    
    var isTextFieldEmpty: Bool {
        return currentMileage.isEmpty
    }
    
    var body: some View {
        ZStack{
            BackgroundView()
            VStack {
                Spacer()
                Image("odometer3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 358, height: 187)
                    .padding(.horizontal, 18)
                    .padding(.top, 10)
                
//                Spacer()
//                    .frame(height: 60)
                
//                LottiePlusView(name: Constants.arduino, loopMode: .loop, animationSpeed: 0.25,  contentMode: .scaleAspectFit)
//                    .frame(width: 200, height: 300)
                
                Text("Jarak tempuh motormu sudah sampai mana ya?")
                    .font(.system(size: 33))
                    .foregroundColor(.white)
                    .padding(.top, 50)
                    .padding(.bottom, 20)
                    .fontWeight(.bold)
                    .frame(maxWidth: 350, alignment: .topLeading)
                
                Rectangle()
                    .fill(Color("BackColor"))
                    .cornerRadius(10)
                    .frame(width: 350, height: 35)
                    .overlay(
                        TextField("Masukan jarak tempuhmu                  Km", text: $currentMileage)
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
                
                Text("Ketahui kondisi part motor Anda dari jarak tempuh yang tertera di odometer.")
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .frame(maxWidth: 350, alignment: .topLeading)
                    .padding(.bottom, 40)
                    .padding(.top, 5)
                
                Spacer()
                
                Button(action: {
                    motorcycleVM.motorcycle.currentMileage = Int(currentMileage)!
                    modelContext.insert(motorcycleVM.motorcycle)
                    isShowingInputLastReceiptView.toggle()
                }) {
                    Text("Lanjutkan")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: 350, height: 45)
                        .background(Color(red: 0.12, green: 0.83, blue: 0.91))
                        .cornerRadius(11)
                }
                .padding(.bottom, 30)
                .disabled(isTextFieldEmpty)
            }
            .navigationDestination(isPresented: $isShowingInputLastReceiptView) {
                InputLastReceiptsView(motorcycle: motorcycleVM.motorcycle)
            }
        } .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    InputOdometerView()
}
