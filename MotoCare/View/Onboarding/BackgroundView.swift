import SwiftUI

struct BackgroundView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
        }
        .background(colorScheme == .dark ? Color.black : Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    BackgroundView()
}
