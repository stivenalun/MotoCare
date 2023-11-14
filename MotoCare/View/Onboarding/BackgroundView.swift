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
