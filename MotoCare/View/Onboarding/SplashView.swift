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
                GeometryReader { proxy in
                    Image("logoo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: proxy.size.width * 0.5)
                        .frame(width: proxy.size.width, height: proxy.size.height)
                }
                VStack {
                    Spacer()
                    Text("Sahabat baik motormu!")
                        .font(.system(size: 18))
                        .dynamicTypeSize(...DynamicTypeSize.large)
                        .foregroundColor(.white)
                    Spacer()
                        .frame(height: 80)
                }
            }
        }
        .background(content: {
            BackgroundView()
        })
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
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

//#Preview {
//    SplashView()
//}

