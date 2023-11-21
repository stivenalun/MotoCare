//
//  InputLastReceiptView.swift
//  MotorCareSwiftData
//
//  Created by Nur Hidayatul Fatihah on 31/10/23.
//

import SwiftUI

struct InputLastReceiptsView: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var motorcycleVM : MotorcycleViewModel
    let someMotorcycle = Motorcycle(/* berikan parameter yang sesuai */)
    let someDate = Date(/* berikan parameter yang sesuai */)
    let someMileage = 10000 // Berikan nilai mileage yang sesuai
    @Bindable var motorcycle: Motorcycle
    
    @State private var isShowingManualReceiptView = false
    @State private var recognizedText = "Now, please scan or manually input your three last maintenance receipt."
    @State private var showingScanningView = false
    
    @State var extractedText1: String?
    @State var extractedText2: String?
    @State var extractedText3: String?
    @State var extractedText4: String?
    @State var extractedText5: String?
    @State var extractedText6: String?
    @State var isScanned: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack{
                BackgroundView()
                VStack{
                    Spacer()
                    Image("nota")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 30)
                        .frame(width: 350, height: 260)
                    
                    Text("Ayo isi riwayat servis part motormu!")
                        .navigationBarBackButtonHidden(true)
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .padding(.top, 45)
                        .frame(maxWidth: DeviceInfo.maxWidth, alignment: .topLeading)
                        .foregroundColor(.white)
                    
                    Text("Isi riwayat servis sparepart motormu dengan cara men-scan 3 resi dari bengkel atau isi manual. Mulai dari busi, oli, v-belt, oli gardan, shock breaker, dan air filter.")
                        .padding(.top, 20)
                        .font(.system(size: 17))
                        .frame(maxWidth: DeviceInfo.maxWidth, alignment: .topLeading)
                        .foregroundColor(.white)
                    Spacer()
                    Spacer()
                    Spacer()
                }
                
                VStack{
                    Spacer()
                    Button(action: {
                        self.showingScanningView = true
                    }) {
                        Text("Scan")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(width: DeviceInfo.maxWidth, height: 45, alignment: .center)
                            .background(Color(red: 0.12, green: 0.83, blue: 0.91))
                            .cornerRadius(11)
                    }
                    .padding(10)
                    
                    NavigationLink(destination: ManualView2(motorcycle: motorcycle), label: {
                        Text("Manual")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: DeviceInfo.maxWidth, height: 45, alignment: .center)
                            .overlay(
                                RoundedRectangle(cornerRadius: 11)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                    } )

                } .padding(.bottom, 30)
            }
            .navigationDestination(isPresented: $isScanned) {
                ScanResultView (
                    extractedText1: $extractedText1,
                    scannedServiceMileage: $extractedText2,
                    extractedText3: $extractedText3,
                    extractedText4: $extractedText4,
                    extractedText5: $extractedText5,
                    extractedText6: $extractedText6,
//                    modelContext: /* berikan nilai modelContext yang sesuai */,
//                    motorcycleVM: /* berikan nilai motorcycleVM yang sesuai */,
                    motorcycle: motorcycle
//                    date: someDate,
//                    maintenanceMileage: someMileage
                )
            }


            .sheet(isPresented: $showingScanningView) {
                ScanDocumentView (
                    recognizedText: $recognizedText, 
                    extractedText1: $extractedText1,
                    extractedText2: $extractedText2,
                    extractedText3: $extractedText3,
                    extractedText4: $extractedText4,
                    extractedText5: $extractedText5,
                    extractedText6: $extractedText6
                )
                .onDisappear {
                    isScanned = true
                    print(isScanned)
                }
            }
            .sheet(isPresented: $isShowingManualReceiptView) {
                ManualView2(motorcycle: motorcycle)
            }
        }
    }
}

// Preview
//struct InputLastReceiptsView_Previews: PreviewProvider {
//    static var previews: some View {
//        InputLastReceiptsView(motorcycle: motorcycleVM.motorcycle)
//    }
//}
