//
//  SettingsView.swift
//  MotorCareSwiftData
//
//  Created by Nur Hidayatul Fatihah on 31/10/23.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var service = BluetoothService()
    @State private var isDeviceConnected = false
    @State private var batteryPercentage = 0
    @State private var isIOTPaired = false
    @State private var isIOTConnected = false
    @State private var showDetectedDevices = false
    @State private var showNotifications = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, content: {
                List(content: {
                    NavigationLink(
                        destination: BluetoothView().environmentObject(service),
                        isActive: $showDetectedDevices,
                        label: {
                            Text("Pair IOT")
                            //                    Button(action: {
                            //
                            //                    }, label: {
                            //
                            //                    })
                        })
                    
                    NavigationLink(
                        destination: NotificationView(),
                        isActive: $showNotifications
                    ) {
                        Text("Notifications")
                    }
                })
                .scrollContentBackground(.hidden)
            })
            .background(content: {
                BackgroundView()
            })
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)

        }
        
    }
}


