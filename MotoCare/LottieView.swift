//
//  LottieView.swift
//  MotoCare
//
//  Created by Stiven on 08/11/23.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let name: String
    let loopMode: LottieLoopMode
    let animaitionSpeed: CGFloat
    
    init(name: String, loopMode: LottieLoopMode = .playOnce, animationSpeed: CGFloat = 1) {
        self.name = name
        self.loopMode = loopMode
        self.animaitionSpeed = animationSpeed
    }
    
    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: name)
        animationView.loopMode = loopMode
        animationView.animationSpeed = animaitionSpeed
        animationView.play()
        return animationView
    }
    
    func updateUIView(_ uiView: Lottie.LottieAnimationView, context: Context) {
        
    }

}
