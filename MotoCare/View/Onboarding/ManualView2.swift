//
//  ManualView2.swift
//  MotoCare
//
//  Created by Stiven on 08/11/23.
//

import SwiftUI

struct ManualView2: View {
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                VStack {
                    ScrollView {
                        Text("Yuk isi 3 riwayat servis terakhir anda.")
                            .foregroundColor(.white)
                            .frame(maxWidth: 320, alignment: .topLeading)
                        Spacer()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Manual")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                }
            }
        }
    }
}


#Preview {
    ManualView2()
}
