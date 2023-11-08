//
//  LottieViewPlus.swift
//  MotoCare
//
//  Created by Stiven on 08/11/23.
//

import SwiftUI
import Lottie

struct LottiePlusView: UIViewRepresentable {
    let name: String
    let loopMode: LottieLoopMode
    let animaitionSpeed: CGFloat
    let contentMode: UIView.ContentMode
    
    let animationView: LottieAnimationView
    
    
    init(name: String, loopMode: LottieLoopMode = .playOnce, animationSpeed: CGFloat = 1, contentMode: UIView.ContentMode = .scaleAspectFit) {
        self.name = name
        self.loopMode = loopMode
        self.animaitionSpeed = animationSpeed
        self.animationView = LottieAnimationView(name: name)
        self.contentMode = contentMode
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.addSubview(animationView)
        animationView.contentMode = contentMode
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        animationView.loopMode = loopMode
        animationView.animationSpeed = animaitionSpeed
        animationView.play()
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }

}
