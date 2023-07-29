//
//  Alert.swift
//  BarcodeScanner
//
//  Created by Ruslan Ismayilov on 7/29/23.
//

import SwiftUI


struct AlertItem : Identifiable {
    let id = UUID()
    let title : String
    let message : String
    let dismissButton : Alert.Button
}

struct AlertContext {
    static let invalidDeviceInput = AlertItem(title: "Invalid device input", message: "Something is wrong with camera. We are unable to capture input.", dismissButton: .default(Text("OK")))
    
    static let invalidScannedType = AlertItem(title: "Invalid scan type", message: "The value scanned is not valid. Tnis app scanes EAN-8 and EAN-13", dismissButton: .default(Text("OK")))
}
