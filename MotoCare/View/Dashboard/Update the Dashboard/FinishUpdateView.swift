//
//  FinishUpdateView.swift
//  MotoCare
//
//  Created by Anita Saragih on 16/11/23.
//
import SwiftUI

struct FinishUpdateView: View {
    @AppStorage("modalopen") var isUpdateModalPresented = false
    
    var body: some View {
        NavigationView{
            ZStack{
                BackgroundView()
                VStack{
                    Text("Update selesai ")
                        .font(.system(size: 31))
                        .fontWeight(.bold)
                        .frame(width: 355, height: 158, alignment: .center)
                        .padding(.top, 100)
                        .foregroundColor(.white)
                    
                    VStack{
                        LottiePlusView(name: Constants.done, loopMode: .playOnce, contentMode: .scaleAspectFill)
                    }
                    
                    VStack{
                        Button(action: {
                            isUpdateModalPresented.toggle()
                        }, label: {
                            Text("Selesai")
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(width: 355, height: 55, alignment: .center)
                                .background(Color(red: 0.12, green: 0.83, blue: 0.91))
                                .cornerRadius(25)
                        })
//                        NavigationLink(destination: MainTabView(), label: {
//                            
//                        })
                    }
                    .padding(.bottom, 50)
                }
            }.navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    FinishUpdateView()
}
