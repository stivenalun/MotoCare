//
//  ModalView.swift
//  MotorCareSwiftData
//
//  Created by Nur Hidayatul Fatihah on 31/10/23.
//

import SwiftUI

struct ModalSparepartView: View {
    @Binding var data: GaugeData?
    @Environment(\.presentationMode) var presentationMode
    @State private var showInnerModal = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center) {
                if let data = data {
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
                Button(action: {
                                    showInnerModal.toggle()
                                }) {
                                    Label("", systemImage: "info.circle")
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                }
                                .sheet(isPresented: $showInnerModal) {
                                    // Inner modal content here
                                    InnerModalView(data: $data)
                                }
                                .frame(height: 50)
                
            }
            .padding()
//            .navigationBarTitle("\(data.labelText)", displayMode: .inline)
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

struct InnerModalView: View {
    @Binding var data: GaugeData?

    var body: some View {
        // Content for the inner modal
        VStack {
            Text("Check uya")
//            if let data = data {
//                switch data.labelText {
//                Text("Check")
//                }
//            }
        }
        .padding()
        .background(Color.gray.opacity(0.9))
        .cornerRadius(15)
        .frame(height: 50) // Set the height to your desired value
    }
}




//
//#Preview {
//    ModalSparepartView(data: .init(value: 30.0, minimum: 0.0, maximum: 100.0, iconSparePart: "engine-oil", labelText: "Oli Mesin", imageSparePart: "EngineOilImage", status: .ganti))
//}
//import SwiftUI
//
//struct ModalSparepartView: View {
//    @Binding var data: GaugeData?
//    @Environment(\.presentationMode) var presentationMode
//    
//    var body: some View {
//        ScrollView(showsIndicators: false) {
//            VStack(alignment: .center) {
//                if let data = data {
//                    Text("\(data.labelText)")
//                        .font(.title3)
//                        .fontWeight(.medium)
//                    Image(data.imageSparePart)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        
//                    ZStack {
//                        Rectangle()
//                            .foregroundColor(data.status.tintColor.opacity(0.3))
//                            .frame(width: 359, height: 42)
//                            .cornerRadius(22)
//                        HStack(spacing:10) {
//                            Image(systemName: data.status.iconStatus)
//                                .resizable()
//                                .frame(width: 22, height:22)
//                                .foregroundColor(data.status.tintColor)
//                            
//                            Text(data.status.modalStatus)
//                                .font(.system(size: 22))
//                                .fontWeight(.bold)
//                                .foregroundColor(data.status.tintColor)
//                        }
//                        .padding(20)
//                        
//                    }
//                    
//                    Text("")
//                    HStack {
//                        Spacer()
//                        Gauge(value: data.value, in: data.minimum...data.maximum) {
//                            
//                        }
//                        .gaugeStyle(.accessoryCircularCapacity)
//                        .scaleEffect(1.80)
//                        .padding(40)
//                        .tint(data.status.tintColor)
//                        .overlay {
//                            Image(data.iconSparePart)
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 45, height: 45)
//                                .cornerRadius(14)
//                                .foregroundColor(.white)
//                        }
//                        Spacer()
//                        Text("Let's see")
//                        Spacer()
//                    }
//                    
//                }
//                
//            }
//            .padding()
////            .navigationBarTitle("\(data.labelText)", displayMode: .inline)
//            .foregroundColor(.white)
//            .navigationBarItems(trailing:
//                                    HStack {
//                Button(action: {
//                    presentationMode.wrappedValue.dismiss()
//                }) {
//                    HStack {
//                        Image(systemName: "xmark.circle.fill")
//                    }
//                    .accentColor(Color(.secondarySystemBackground))
//                }
//            }
//            )
//        }
//    }
//}

//
//#Preview {
//    ModalSparepartView(data: .init(value: 30.0, minimum: 0.0, maximum: 100.0, iconSparePart: "engine-oil", labelText: "Oli Mesin", imageSparePart: "EngineOilImage", status: .ganti))
//}
