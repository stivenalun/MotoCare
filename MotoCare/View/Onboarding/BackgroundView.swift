//
//  BackgroundView.swift
//  MotoCare
//
//  Created by Nur Hidayatul Fatihah on 09/11/23.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    BackgroundView()
}
