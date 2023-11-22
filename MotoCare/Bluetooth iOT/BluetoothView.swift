//
//  BluetoothView.swift
//  MotoCare
//
//  Created by Stiven on 16/11/23.
//

import SwiftUI

struct BluetoothView: View {
    @EnvironmentObject var service: BluetoothService

    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Spacer()
                Text("Status : \(service.peripheralStatus.rawValue)")
                    .font(.title)
                    .foregroundColor(service.peripheralStatus == .connected ? .green : .red)
                
//                Text("\(service.totalTrip) meter")
//                    .font(.largeTitle)
//                    .fontWeight(.heavy)
//                    .foregroundColor(.white)
                
                Text("\(service.totalTrip / 1000) km")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    let newValue = service.peripheralStatus
                    print(newValue)
                    
                    if newValue == .connected {
                        // Disconnect logic here
                        // service.disconnect() or whatever your disconnect logic is
                        service.disconnectPeripheral()
                    } else {
                        service.startScanning()
                        // Connect logic here
                    }
                    
                    // Additional logic as needed
                    
                }) {
                    Text(service.peripheralStatus == .connected ? "Disconnect from Bluetooth" : "Connect to Bluetooth")
                        .padding()
                        .background(service.peripheralStatus == .connected ? Color.red : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct BluetoothView_Previews: PreviewProvider {
    static var previews: some View {
        BluetoothView()
    }
}
