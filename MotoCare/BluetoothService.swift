//
//  BluetoothService.swift
//  MotoCare
//
//  Created by Stiven on 16/11/23.
//


import Foundation
import CoreBluetooth

enum ConnectionStatus: String {
    case connected
    case disconnected
    case scanning
    case connecting
    case error
}

let sensorService: CBUUID = CBUUID(string: "d888a9c2-f3cc-11ed-a05b-0242ac120003")
let sensorCharacteristic: CBUUID = CBUUID(string: "d888a9c3-f3cc-11ed-a05b-0242ac120003")

class BluetoothService: NSObject, ObservableObject {
    
    private var centralManager: CBCentralManager!
    @Published var discoveredPeripherals: [CBPeripheral] = []
    
    var hallSensorPeripheral: CBPeripheral?
    @Published var peripheralStatus: ConnectionStatus = .disconnected
    @Published var totalTrip: Int = 0
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func scanForPeripherals() {
        peripheralStatus = .scanning
        centralManager.scanForPeripherals(withServices: nil)
    }
    
}

extension BluetoothService: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            print("CB Powered On")
            scanForPeripherals()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        if peripheral.name == "Nano 33 IoT" {
            print("1 Discovered \(peripheral.name ?? "no name")")
            hallSensorPeripheral = peripheral
            centralManager.connect(hallSensorPeripheral!)
            peripheralStatus = .connecting
        } else if peripheral.name == "Arduino" {
            print("2 Discovered \(peripheral.name ?? "no name")")
            hallSensorPeripheral = peripheral
            centralManager.connect(hallSensorPeripheral!)
            peripheralStatus = .connecting
        }
        discoveredPeripherals.append(peripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheralStatus = .connected
        
        peripheral.delegate = self
        peripheral.discoverServices([sensorService])
        centralManager.stopScan()
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        peripheralStatus = .disconnected
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        peripheralStatus = .error
        print(error?.localizedDescription ?? "no error")
    }
    
    //add func connect to bluetooth
    func connectToPeripheral(peripheral: CBPeripheral) {
        hallSensorPeripheral = peripheral
        centralManager.connect(hallSensorPeripheral!)
        peripheralStatus = .connecting
    }

    
}

extension BluetoothService: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        for service in peripheral.services ?? [] {
            if service.uuid == sensorService {
                print("found service for \(sensorService)")
                peripheral.discoverCharacteristics([sensorCharacteristic], for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        for characteristic in service.characteristics ?? [] {
            peripheral.setNotifyValue(true, for: characteristic)
            print("found characteristic, waiting on values.")
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if characteristic.uuid == sensorCharacteristic {
            if let data = characteristic.value {
                if let stringValue = String(data: data, encoding: .utf8) {
                    print("Received data: \(stringValue)")
                    
                    let sensorData: Int = Int(stringValue) ?? 0
                    totalTrip = sensorData
                    
                    // Handle the received data here (e.g., display it in your app's UI)
                }
            }
            
        }
        
        
    }
    
    
    
}
