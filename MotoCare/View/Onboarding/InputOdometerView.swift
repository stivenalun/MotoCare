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
    @FocusState var isInputActive: Bool
    
    var isTextFieldEmpty: Bool {
        return currentMileage.isEmpty
    }
    
    var body: some View {
        ZStack{
            BackgroundView()
            VStack {
                Image("odometer1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 18)
                    .padding(.top, 60)
                
//                Spacer()
//                    .frame(height: 60)
                
//                LottiePlusView(name: Constants.arduino, loopMode: .loop, animationSpeed: 0.25,  contentMode: .scaleAspectFit)
//                    .frame(width: 200, height: 300)
                
                Text("Jarak tempuh motormu sudah sampai mana ya?")
                    .font(.system(size: 34))
                    .foregroundColor(.white)
                    .padding(.top, 100)
                    .fontWeight(.bold)
                    .frame(maxWidth: 330, alignment: .topLeading)
                
                Rectangle()
                    .fill(Color("BackColor"))
                    .cornerRadius(10)
                    .frame(width: 330, height: 35)
                    .overlay(
                        TextField("Masukan jarak tempuhmu", text: $currentMileage)
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
                
                Text("Ketahui kondisi part motor Anda dari angka yang tertera di odometer.")
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .frame(maxWidth: 330, alignment: .topLeading)
                    .padding(.bottom, 30)
                
    
                Spacer()
                
                Button(action: {
                    let motorcycle = Motorcycle(id_motorcycle: UUID(), currentMileage: Int(currentMileage) ?? 0)
                    
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
                        .frame(width: 335, height: 45)
                        .background(Color(red: 0.12, green: 0.83, blue: 0.91))
                        .cornerRadius(20)
                }
                    .padding(.bottom, 30)
                .disabled(isTextFieldEmpty)
            }
            .navigationDestination(isPresented: $isShowingInputLastReceiptView) {
                InputLastReceiptsView()
            }
        } .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    InputOdometerView()
}
