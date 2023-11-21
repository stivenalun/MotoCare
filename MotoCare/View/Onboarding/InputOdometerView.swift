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
    @FocusState var isInputActive: Bool
    
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
                    .frame(width: 328, height: 187)
                    .padding(.horizontal, 18)
                    .padding(.top, 10)
                
                //                Spacer()
                //                    .frame(height: 60)
                
                //                LottiePlusView(name: Constants.arduino, loopMode: .loop, animationSpeed: 0.25,  contentMode: .scaleAspectFit)
                //                    .frame(width: 200, height: 300)
                
                Text("Jarak tempuh motormu sudah sampai mana ya?")
                    .font(.system(size: 33))
                    .foregroundColor(.white)
                    .padding(.top, 30)
                    .padding(.bottom, 10)
                    .fontWeight(.bold)
                    .frame(maxWidth: DeviceInfo.maxWidth, alignment: .topLeading)
                
                Rectangle()
                    .fill(Color.gray.opacity(0.7))
                    .cornerRadius(10)
                    .frame(width: DeviceInfo.maxWidth, height: 35)
                    .overlay(
                        TextField("Masukan jarak tempuhmu saat ini", text: $currentMileage)
                            .foregroundColor(.primary)
                            .padding(.horizontal, 10)
                            .keyboardType(.numberPad)
                            .focused($isInputActive)
//                            .toolbar {
//                                ToolbarItemGroup(placement: .keyboard) {
//                                    Spacer()
//                                    Button("Done"){
//                                        isInputActive = false
//                                    }
//                                }
//                            }
                    )
                
                Text("Ketahui kondisi part motor Anda dari jarak tempuh yang tertera di odometer.")
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .frame(maxWidth: DeviceInfo.maxWidth, alignment: .topLeading)
                    .padding(.bottom, 30)
                    .padding(.top, 5)
                
                Spacer()
                
                Button(action: {
                    saveMotorcycle()
                    isShowingInputLastReceiptView.toggle()
                }) {
                    Text("Lanjutkan")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: DeviceInfo.maxWidth, height: 45)
                        .background(Color(red: 0.12, green: 0.83, blue: 0.91))
                        .cornerRadius(11)
                }
                .padding(.bottom, 30)
                .disabled(isTextFieldEmpty)
            }
            .navigationDestination(isPresented: $isShowingInputLastReceiptView) {
                InputLastReceiptsView(motorcycle: motorcycle)
            }
        } /*.ignoresSafeArea(.keyboard)*/
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
