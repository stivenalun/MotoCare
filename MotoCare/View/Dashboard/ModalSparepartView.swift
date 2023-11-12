//
//  ModalView.swift
//  MotorCareSwiftData
//
//  Created by Nur Hidayatul Fatihah on 31/10/23.
//

import SwiftUI

struct ModalSparepartView: View {
    var data: GaugeData
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center) {
                Image(data.imageSparePart)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    
                ZStack {
                    Rectangle()
                        .foregroundColor(data.status.tintColor.opacity(0.3))
                        .frame(width: 359, height: 42)
                        .cornerRadius(22)
                    HStack(spacing:10) {
                        Image(systemName: data.status.iconStatus)
                            .resizable()
                            .frame(width: 22, height:22)
                            .foregroundColor(data.status.tintColor)
                        
                        Text(data.status.modalStatus)
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                            .foregroundColor(data.status.tintColor)
                    }
                    .padding(20)
                    
                }
                
                Text("")
                Gauge(value: data.value, in: data.minimum...data.maximum) {
                    
                }
                .gaugeStyle(.accessoryCircularCapacity)
                .scaleEffect(1.80)
                .padding(40)
                .tint(data.status.tintColor)
                .overlay {
                    Image(data.iconSparePart)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 45, height: 45)
                        .cornerRadius(14)
                        .foregroundColor(.white)
                }
            }
            .padding()
            .navigationBarTitle("\(data.labelText)", displayMode: .inline)
            .foregroundColor(.white)
            .navigationBarItems(trailing:
                                    HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "xmark.circle.fill")
                    }
                    .accentColor(Color(.secondarySystemBackground))
                }
            }
            )
        }
    }
}


#Preview {
    ModalSparepartView(data: .init(value: 30.0, minimum: 0.0, maximum: 100.0, iconSparePart: "engine-oil", labelText: "Oli Mesin", imageSparePart: "EngineOilImage", status: .ganti))
}
