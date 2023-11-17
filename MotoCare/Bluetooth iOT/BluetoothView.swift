//
//  BluetoothView.swift
//  MotoCare
//
//  Created by Stiven on 16/11/23.
//

import SwiftUI

struct BluetoothView: View {

    @StateObject var service = BluetoothService()

    var body: some View {
        ZStack{
            BackgroundView()
            VStack {
                
                Text(service.peripheralStatus.rawValue)
                    .font(.title)
                    .foregroundColor(.white)
                
                Text("\(service.totalTrip) meter")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                Text("\(service.totalTrip / 1000) km")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
            }
            .padding()
            .onChange(of: service.peripheralStatus) { oldValue, newValue in
                print(newValue)
                
                if newValue != .connected {
                    service.scanForPeripherals()
                }
            }
        }
    }
}

struct BluetoothView_Previews: PreviewProvider {
    static var previews: some View {
        BluetoothView()
    }
}
