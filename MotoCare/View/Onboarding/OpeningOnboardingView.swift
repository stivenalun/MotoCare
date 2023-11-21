//
//  OpeningOnboardingView.swift
//  MotorCareSwiftData
//
//  Created by Nur Hidayatul Fatihah on 31/10/23.
//

import SwiftUI

struct OpeningOnboardingView: View {
    
    @StateObject var motorcycleVM = MotorcycleViewModel()
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack{
                    BackgroundView()
                    VStack {
                        Image("lexy")
                            .resizable()
                            .padding(.horizontal, 35)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width)
                        
                        Text("Perawatan motor dibuat mudah")
                            .font(.system(size: adaptiveTextSize()))
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .padding(.horizontal, 16)
                        
                        Text("Estimasikan waktu terbaik kapan motormu harus diperiksa atau diperbaiki di bengkel. \n\nMotoCare, sobat terbaik anda")
                            .font(.system(size: adaptiveTextSize()))
                            .padding(.top, 1)
                            .padding(.bottom, 100)
                            .padding(.horizontal, 16)
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    
                    VStack{
                        Spacer()
                        NavigationLink(destination: InputOdometerView()) {
                            Text("Lanjutkan")
                                .font(.system(size: adaptiveTextSize2()))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, maxHeight: 44, alignment: .center)
//                                .frame(width: 357, height: 44, alignment: .center)
                                .background(Color(red: 0.12, green: 0.83, blue: 0.91))
                                .cornerRadius(11)
                                .padding(.bottom, 30)
                                .padding(.horizontal, 16)
                        }
                    }
                }
                .padding(.bottom, 30)
                .padding(.horizontal, 16)
            }
        }
        .environmentObject(motorcycleVM)
    }
    private func adaptiveTextSize() -> CGFloat {
            if UIDevice.current.userInterfaceIdiom == .pad {
                // Ukuran font untuk iPad
                return 24
            } else {
                // Ukuran font untuk iPhone
                return 17
            }
        }
    
    private func adaptiveTextSize2() -> CGFloat {
            if UIDevice.current.userInterfaceIdiom == .pad {
                // Ukuran font untuk iPad
                return 30
            } else {
                // Ukuran font untuk iPhone
                return 20
            }
        }
}

#Preview {
    OpeningOnboardingView()
}
        
