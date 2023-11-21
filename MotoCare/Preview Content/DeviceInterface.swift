//
//  DeviceInterface.swift
//  MotoCare
//
//  Created by Stiven on 21/11/23.
//

import SwiftUI

struct DeviceInfo {
    static var maxWidth: CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            return 550
        default:
            return 345
        }
    }
}
