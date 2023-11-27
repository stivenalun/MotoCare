//
//  DashboardViewModel.swift
//  MotoCare
//
//  Created by Stiven on 27/11/23.
//

import Foundation


class DashboardViewModel: ObservableObject {
    @Published var bluetoothService = BluetoothService()
}
