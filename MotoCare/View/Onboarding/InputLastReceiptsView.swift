//
//  InputLastReceiptView.swift
//  MotorCareSwiftData
//
//  Created by Nur Hidayatul Fatihah on 31/10/23.
//

import SwiftUI

struct InputLastReceiptsView: View {
    @State private var isShowingManualReceiptView = false
    @State private var recognizedText = "Now, please scan or manually input your three last maintenance receipt."
    @State private var showingScanningView = false
    
    @State var extractedText1: String?
    @State var extractedText2: String?
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
                    
                    Text("Ayo isi riwayat servis part motormu!")
                        .navigationBarBackButtonHidden(true)
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .padding(.top, 45)
                        .frame(maxWidth: 345, alignment: .topLeading)
                        .foregroundColor(.white)
                    
                    Text("Isi riwayat servis sparepart motormu dengan cara men-scan 3 resi dari bengkel atau isi manual. Mulai dari busi, oli, v-belt, oli gardan, shock breaker, dan air filter.")
                        .padding(.top, 20)
                        .font(.system(size: 17))
                        .frame(maxWidth: 345, alignment: .topLeading)
                        .foregroundColor(.white)
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
                            .frame(width: 335, height: 45, alignment: .center)
                            .background(Color(red: 0.12, green: 0.83, blue: 0.91))
                            .cornerRadius(11)
                    }
                    .padding(10)
                    
                    NavigationLink(destination: ManualView(), label: {
                        Text("Manual")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 335, height: 45, alignment: .center)
                            .background(Color(red: 0.12, green: 0.83, blue: 0.91))
                            .cornerRadius(11)
                    } )
                } .padding(.bottom, 30)
            }
            .navigationBarBackButtonHidden(false)
            .navigationDestination(isPresented: $isScanned, destination: {
                ScanResultView(extractedText1: $extractedText1, extractedText2: $extractedText2)
            })
            .sheet(isPresented: $showingScanningView) {
                ScanDocumentView(
                    recognizedText: $recognizedText,
                    extractedText1: $extractedText1, extractedText2: $extractedText2
                )
                .onDisappear {
                    isScanned = true
                    print(isScanned)
                }
            }
        }
    }
}

#Preview {
    InputLastReceiptsView()
}
