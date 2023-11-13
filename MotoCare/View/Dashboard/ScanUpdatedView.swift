//
//  ScanUpdatedView.swift
//  MotoCare
//
//  Created by Anita Saragih on 13/11/23.
//

import SwiftUI

struct ScanUpdatedView: View {
    
    var body: some View {
        ZStack{
            BackgroundView()
            ScrollView{
                VStack(spacing: 20) {
                    Text("Spare Part diperbarui!")
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .frame(width: 355, height: 60, alignment: .topLeading)
                    HStack{
                        Rectangle()
                          .foregroundColor(.clear)
                          .frame(width: 176, height: 123)
                          .background(
                            LinearGradient(
                              stops: [
                                Gradient.Stop(color: Color(red: 0.16, green: 0.22, blue: 0.23), location: 0.08),
                                Gradient.Stop(color: Color(red: 0.08, green: 0.09, blue: 0.09), location: 1.00),
                              ],
                              startPoint: UnitPoint(x: 0.5, y: 0),
                              endPoint: UnitPoint(x: 0.5, y: 1)
                            )
                          )
                          .cornerRadius(20)
                        
                        Rectangle()
                          .foregroundColor(.clear)
                          .frame(width: 176, height: 123)
                          .background(
                            LinearGradient(
                              stops: [
                                Gradient.Stop(color: Color(red: 0.16, green: 0.22, blue: 0.23), location: 0.08),
                                Gradient.Stop(color: Color(red: 0.08, green: 0.09, blue: 0.09), location: 1.00),
                              ],
                              startPoint: UnitPoint(x: 0.5, y: 0),
                              endPoint: UnitPoint(x: 0.5, y: 1)
                            )
                          )
                          .cornerRadius(20)
                    }
                }
            }
        }
    }
}

#Preview {
    ScanUpdatedView()
}
