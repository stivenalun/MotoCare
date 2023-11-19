//
//  SettingsView.swift
//  MotorCareSwiftData
//
//  Created by Nur Hidayatul Fatihah on 31/10/23.
//

import SwiftUI

struct SettingsView: View {
   @State private var isDeviceConnected = false
   @State private var batteryPercentage = 0
   @State private var isIOTPaired = false
   @State private var isIOTConnected = false
   @State private var showDetectedDevices = false
   @State private var showNotifications = false

   var body: some View {
       NavigationView {
           ZStack {
               BackgroundView()
               VStack(alignment: .leading) {
                  Form {
                      Section("IOT Configuration") {
                          List {
                              HStack {
                                 Text("Status")
                                 Spacer()
                                 Text(isDeviceConnected ? "Connected" : "Disconnected")
                                     .foregroundColor(isDeviceConnected ? .green : .red)
                              }
                              HStack {
                                 Text("Battery")
                                 Spacer()
                                 Text("\(batteryPercentage)%")
                              }
                          }
                      }

                      Section {
                          if isDeviceConnected {
                              Button(action: {
                                 // Action to disconnect IoT device
                                 isDeviceConnected = false
                                 batteryPercentage = 0
                                 isIOTPaired = false
                                 isIOTConnected = false
                              }) {
                                 Text("Disconnect")
                                     .foregroundStyle(.red)
                              }
                          }
                      }

                      NavigationLink(
                          destination: BluetoothView(),
                          isActive: $isIOTConnected
                      ) {
                          Button(action: {
                              // Action to pair IoT device
                              isDeviceConnected = true
                              batteryPercentage = 70
                              isIOTPaired = false
                              isIOTConnected = true
                          }) {
                              Text("Pair IoT")
                                 .foregroundStyle(.blue)
                          }
                      }

                      NavigationLink(
                          destination: NotificationView(),
                          isActive: $showNotifications
                      ) {
                          Text("Notifications")
                      }
                  }
                  .scrollContentBackground(.hidden)
                  .navigationTitle("Settings")
               }
           } .onAppear {
               isDeviceConnected = true
               batteryPercentage = 70
               isIOTPaired = false
               isIOTConnected = true
           }
       }
   }
}


//struct DetectedDevicesView: View {
//    @Binding var isIOTConnected: Bool
//    @Binding var isDeviceConnected: Bool
//
//    var body: some View {
//        List {
//            // List of detected devices
//            Text("Detected Devices 1")
//            
//            Section {
//                Button(action: {
//                    // Action to connect to the selected device
//                    isIOTConnected = true
//                    isDeviceConnected = true // Update the status to connected
//                }) {
//                    Text("Connect")
////                        .background(Color("TabIconoColor"))
////                        .cornerRadius(14)
//                }
//            }
//        }
//        .navigationBarTitle("Pair IoT")
//    }
//}


#Preview {
    SettingsView()
}
