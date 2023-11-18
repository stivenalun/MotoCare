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
            ZStack{
                BackgroundView()
                VStack {
                    Image("lexy")
                        .resizable()
                        .padding(.horizontal, 35)
                        .aspectRatio(contentMode: .fit)
                    
                    Text("Perawatan motor dibuat mudah")
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: 350, alignment: .topLeading)
                    
                    Text("Estimasikan waktu terbaik kapan motormu harus diperiksa atau diperbaiki di bengkel. \n\nMotoCare, sobat terbaik anda")
                        .font(.system(size: 17))
                        .padding(.top, 1)
                        .padding(.bottom, 100)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: 350, alignment: .topLeading)
                }
                
                VStack{
                    Spacer()
                    NavigationLink(destination: InputOdometerView()) {
                        Text("Lanjutkan")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(width: 350, height: 44)
                            .background(Color(red: 0.12, green: 0.83, blue: 0.91))
                            .cornerRadius(11)
                            .padding(.bottom, 30)
                    }
                }
            }
        }
        .environmentObject(motorcycleVM)
    }
}

#Preview {
    OpeningOnboardingView()
}
        
