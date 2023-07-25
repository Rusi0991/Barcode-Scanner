//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by Ruslan Ismayilov on 6/25/23.
//

import SwiftUI

struct BarcodeScannerView: View {
    @State private var scannedCode = ""
    var body: some View {
        NavigationView {
            VStack(alignment: .center){
                ScannerView(scannedCode: $scannedCode)
//                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .frame(minWidth: 300, idealWidth: 400, maxWidth: 600, minHeight: 300, idealHeight: 400, maxHeight: 500, alignment: .top)
                
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeScannerView()
    }
}
