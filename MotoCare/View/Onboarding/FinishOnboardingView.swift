//
//  FinishOnboardingView.swift
//  MotorCareSwiftData
//
//  Created by Nur Hidayatul Fatihah on 31/10/23.
//

import SwiftUI

struct FinishOnboardingView: View {
    var body: some View {
        NavigationView{
            ZStack{
                BackgroundView()
                VStack{
                    Text("Setup selesai. \n\nYuk langsung dilihat \nstatus kondisi motormu!")
                        .font(.system(size: 31))
                        .fontWeight(.bold)
                        .frame(width: 355, height: 158, alignment: .topLeading)
                        .padding(.top, 100)
                        .foregroundColor(.white)
                    
                    VStack{
                        LottiePlusView(name: Constants.lego, loopMode: .loop, contentMode: .scaleAspectFill)
                    }
                    
                    VStack{
                        NavigationLink(destination: MainTabView(), label: {
                            Text("Lanjutkan")
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(width: 355, height: 55, alignment: .center)
                                .background(Color(red: 0.12, green: 0.83, blue: 0.91))
                                .cornerRadius(25)
                        })}
                    .padding(.bottom, 50)
                }
            }.navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    FinishOnboardingView()
}
