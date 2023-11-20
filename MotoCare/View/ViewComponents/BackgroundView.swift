import SwiftUI

struct BackgroundView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
<<<<<<< HEAD:MotoCare/View/ViewComponents/BackgroundView.swift
        Image("background")
            .resizable()
            .edgesIgnoringSafeArea(.all)
=======
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
        }
        .background(colorScheme == .dark ? Color.black : Color.white)
        .edgesIgnoringSafeArea(.all)
>>>>>>> container-baru:MotoCare/View/Onboarding/BackgroundView.swift
    }
}

#Preview {
    BackgroundView()
}
