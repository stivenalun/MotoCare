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
                    .preferredColorScheme(.dark)
            } else if goToDashboard {
                MainTabView()
                    .preferredColorScheme(.dark)
            } else {
                Rectangle()
                Color("Black")
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 371, height: 231)
                VStack{
                    Spacer()
                    Text("Sahabat baik motormu!")
                        .font(.system(size: 17))
                        .foregroundColor(.white)
                        .padding(.bottom, 80)
                }
            }
        }
        .background(content: {
            BackgroundView()
        })
        .edgesIgnoringSafeArea(.all)
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
