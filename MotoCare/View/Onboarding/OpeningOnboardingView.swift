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
                    Image("lexyy")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 40)
                    
                    Text("Perawatan motor dibuat mudah")
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .frame(maxWidth: 345, alignment: .topLeading)
                        .padding(.bottom, 10)
                    
                    Text("Estimasikan waktu terbaik kapan motormu harus diperiksa atau diperbaiki di bengkel. \n\nMotomo, sobat terbaik anda")
                        .font(.system(size: 17))
                        .foregroundColor(Color.white)
                        .frame(maxWidth: 345, alignment: .topLeading)
                    Spacer()
                        .frame(height: 100)
                }
                
                VStack{
                    Spacer()
                    NavigationLink(destination: InputOdometerView()) {
                        Text("Lanjutkan")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(width: 345, height: 44)
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

//#Preview {
//    OpeningOnboardingView()
//}
        
