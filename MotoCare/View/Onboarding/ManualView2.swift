//
//  ManualView2.swift
//  MotoCare
//
//  Created by Stiven on 08/11/23.
//

import SwiftUI

struct ManualView2: View {
    var body: some View {
        ZStack{
            BackgroundView()
            VStack{
                Text("Isi Manual")
                    .foregroundColor(.white)
                    .font(.system(size: 28))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 3)
                    .frame(maxWidth: 320, alignment: .topLeading)
                    
                Text("Yuk isi 3 riwayat servis terakhir anda.")
                    .foregroundColor(.white)
                    .frame(maxWidth: 320, alignment: .topLeading)
                Spacer()
                
                HStack{
                    Text("sd")
                        .foregroundStyle(.white)
                        .font(.system(size: 28))
                    
                }
                Spacer()
            }
        }
    }
}

#Preview {
    ManualView2()
}
