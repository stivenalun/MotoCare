import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Image("background")
            .resizable()
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    BackgroundView()
}

