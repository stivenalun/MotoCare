//
//  SplashView.swift
//  MotoCare
//
//  Created by Stiven on 09/11/23.
//


import SwiftUI
import SwiftData

struct SplashView: View {
    
    @Query var motorcycles: [Motorcycle]
    @State var isActive: Bool = false
    @State var goToDashboard = false
    
    var body: some View {
        ZStack {
            if self.isActive {
                OpeningOnboardingView()
            } else if goToDashboard {
                MainTabView()
            } else {
                Rectangle()
                Color("Black")
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 221, height: 101)
                VStack{
                    Spacer()
                    Text("Your Motorcycle Companion App")
                        .foregroundColor(.white)
                        .padding(.bottom, 60)
                }
            }
        } .edgesIgnoringSafeArea(.all)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    if motorcycles.isEmpty {
                        self.isActive = true
                    } else {
                        self.goToDashboard = true
                    }
                    
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
