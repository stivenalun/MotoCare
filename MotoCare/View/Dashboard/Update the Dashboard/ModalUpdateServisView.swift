//
//  ModalUpdateServisView.swift
//  MotoCare
//
//  Created by Nur Hidayatul Fatihah on 13/11/23.
//

import SwiftUI
import SwiftData

struct ModalUpdateServisView: View {
    @EnvironmentObject var motorcycleVM : MotorcycleViewModel
    @Bindable var motorcycle: Motorcycle
    
    @State private var isShowingManualReceiptView = false
    @State private var recognizedText = "Now, please scan or manually input your three last maintenance receipt."
    @State private var showingScanningView2 = false
    
    @State var extractedUpdatedText1: String?
    @State var UpdatescannedServiceMileage: String?
    @State var isScanned: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack{
                BackgroundView()
                VStack{
                    Image("receipt")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 50)
                        .frame(width: 350, height: 280)
                    
                    Text("Perbarui riwayat servis sparepart motor.")
                        .navigationBarBackButtonHidden(true)
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .padding(.top, 45)
                        .frame(maxWidth: 345, alignment: .topLeading)
                        .foregroundColor(.white)
                    
                    Text("Perbarui kondisi spare-part motormu dengan men-scan resi atau isi manual. ")
                        .padding(.top, 20)
                        .font(.system(size: 17))
                        .frame(maxWidth: 345, alignment: .topLeading)
                        .foregroundColor(.white)
                    Spacer()
                }
                
                VStack{
                    Spacer()
                    Button(action: {
                        self.showingScanningView2 = true
                    }) {
                        Text("Scan")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(width: 335, height: 45, alignment: .center)
                            .background(Color(red: 0.12, green: 0.83, blue: 0.91))
                            .cornerRadius(11)
                    }
                    .padding(10)
                    
                    NavigationLink(destination: ManualUpdateView(motorcycle: motorcycle), label: {
                        Text("Manual")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(width: 335, height: 45, alignment: .center)
                            .background(Color(red: 0.12, green: 0.83, blue: 0.91))
                            .cornerRadius(11)
                    } )
                    
                } .padding(.bottom, 30)
            }
            .navigationDestination(isPresented: $isScanned) {
                UpdateScanResultView (
                    extractedUpdatedText1: $extractedUpdatedText1,
                    UpdatescannedServiceMileage: $UpdatescannedServiceMileage, motorcycle: motorcycle
                )
            }
            .sheet(isPresented: $showingScanningView2) {
                UpdateScannDocumentView (
                    recognizedText: $recognizedText, extractedUpdatedText1: $extractedUpdatedText1, UpdatescannedServiceMileage: $UpdatescannedServiceMileage
                )
                .onDisappear {
                    isScanned = true
                    print(isScanned)
                    //                }
                }
                .sheet(isPresented: $isShowingManualReceiptView) {
                    ManualInputMaintenanceHistory(motorcycle: motorcycleVM.motorcycle)
                }
            }
        }
    }
}

//#Preview {
//    ModalUpdateServisView()
//}
