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
                    Spacer()
                    Image("UpdateImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 30)
                        .frame(width: 250, height: 160)
                    
                    Text("Perbarui riwayat servis sparepart")
                        .navigationBarBackButtonHidden(true)
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .padding(.top, 45)
                        .frame(maxWidth: 350, alignment: .topLeading)
                        .foregroundColor(.white)
                    
                    Text("Perbarui kondisi spare-part motormu dengan men-scan resi atau isi manual.")
                        .padding(.top, 20)
                        .font(.system(size: 17))
                        .frame(maxWidth: 350, alignment: .topLeading)
                        .foregroundColor(.white)
                    Spacer()
                    Spacer()
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
                            .frame(width: 350, height: 45, alignment: .center)
                            .background(Color(red: 0.12, green: 0.83, blue: 0.91))
                            .cornerRadius(11)
                    }
                    .padding(10)
                    
                    NavigationLink(destination: ManualUpdateView(motorcycle: motorcycle), label: {
                        Text("Manual")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 350, height: 45, alignment: .center)
                            .overlay(
                                RoundedRectangle(cornerRadius: 11)
                                    .stroke(Color.white, lineWidth: 2)
                            )
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
                UpdateScanDocumentView (
                    recognizedText: $recognizedText, extractedUpdatedText1: $extractedUpdatedText1, UpdatescannedServiceMileage: $UpdatescannedServiceMileage
                )
                .onDisappear {
                    isScanned = true
                    print(isScanned)
                    //                }
                }
                .sheet(isPresented: $isShowingManualReceiptView) {
                    ManualUpdateView(motorcycle: motorcycleVM.motorcycle)
                }
            }
        }
    }
}

//#Preview {
//    ModalUpdateServisView()
//}
