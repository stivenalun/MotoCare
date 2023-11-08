//
//  OpeningOnboardingView.swift
//  MotorCareSwiftData
//
//  Created by Nur Hidayatul Fatihah on 31/10/23.
//

import SwiftUI

struct OpeningOnboardingView: View {
    
    @State var isOdometerViewPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack{
                BackgroundView()
                VStack {
                    Image("lexy")
                        .resizable()
                        .padding(.horizontal, 25)
                        .aspectRatio(contentMode: .fit)
                    
                    Text("Perawatan motor \nlebih mudah")
                        .padding(.leading, -40)
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    
                    Text("Motocare akan memberikan rekomendasi waktu terbaik kapan motor kamu harus diperiksa, atau diperbaiki di bengkel. \n\nPengetahuan teknisi motor sekarang di genggaman kamu!")
                        .font(.system(size: 17))
                        .frame(width: 355)
                        .padding(.top, 30)
                        .foregroundColor(Color.white)
                    
                    NavigationLink(destination: InputOdometerView()) {
                        Text("Lanjutkan")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(width: 335, height: 55)
                            .background(Color(red: 0.12, green: 0.83, blue: 0.91))
                            .cornerRadius(25)
                            .padding(.top, 30)
                    }
                }
            }
        }
    }
}

#Preview {
    OpeningOnboardingView()
}
        
