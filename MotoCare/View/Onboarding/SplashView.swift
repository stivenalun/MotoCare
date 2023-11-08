//
//  SplashView.swift
//  MotoCare
//
//  Created by Stiven on 09/11/23.
//


import SwiftUI

struct SplashView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            if self.isActive {
                OpeningOnboardingView()
            } else {
                Rectangle()
                    .background(Color.black)
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 221, height: 101)
                VStack{
                    Spacer()
                    Text("Your Motorcycle Companion App")
                        .foregroundColor(.white)
                        .padding(.bottom, 30)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
        
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
