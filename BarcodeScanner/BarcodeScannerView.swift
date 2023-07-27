//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by Ruslan Ismayilov on 6/25/23.
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

struct BarcodeScannerView: View {
    @State private var scannedCode = ""
    @State private var alertItem : AlertItem?
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center){
                ScannerView(scannedCode: $scannedCode, alertItem: $alertItem)
                    .frame(maxWidth: .infinity, maxHeight: 300)

                
                Spacer().frame(height: 60)
                
                Label("Scanned Barcode", systemImage: "barcode.viewfinder")
                    .font(.title)
                
                Text(scannedCode.isEmpty ? "Not Yet Scanned" : scannedCode)
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(scannedCode.isEmpty ? .red : .green  )
                    .padding()
                
               
            }
            .navigationTitle("Barcode Scanner")
            .alert(item: $alertItem) { alertItem in
                Alert(title: Text(alertItem.title),
                      message: Text(alertItem.message),
                      dismissButton: .default(Text("OK")))
            }
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeScannerView()
    }
}
