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
    
    @State var extractedText: String?
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
                        .frame(width: 350, height: 310)
                    
                    Text("Yuk update kondisi spare-partmu!")
                        .navigationBarBackButtonHidden(true)
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .padding(.top, 15)
                        .frame(width: 355, height: 100, alignment: .topLeading)
                        .foregroundColor(.white)
                    
                    Text("Update otomatis kondisi spare-partmu dengan scan 1 sampai 3 resi perbaikanmu. Bisa juga update kondisi spare-partmu secara manual.")
                        .padding(.top, 20)
                        .font(.system(size: 17))
                        .frame(width: 355, height: 100, alignment: .topLeading)
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
                            .frame(width: 335, height: 55, alignment: .center)
                            .background(Color(red: 0.12, green: 0.83, blue: 0.91))
                            .cornerRadius(25)
                    }
                    .padding(10)
                    
                    NavigationLink(destination: ManualView(), label: {
                        Text("Manual")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(width: 335, height: 55, alignment: .center)
                            .background(Color(red: 0.12, green: 0.83, blue: 0.91))
                            .cornerRadius(25)
                    } )
                    Spacer()
                        .frame(height: 45)
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $isScanned, destination: {
                ScanResultView(extractedText: $extractedText)
            })
            .sheet(isPresented: $showingScanningView) {
                ScanDocumentView(
                    recognizedText: $recognizedText,
                    extractedText: $extractedText
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
