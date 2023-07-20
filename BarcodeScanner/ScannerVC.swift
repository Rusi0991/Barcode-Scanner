//
//  ScannerVC.swift
//  BarcodeScanner
//
//  Created by Ruslan Ismayilov on 6/29/23.
//

import UIKit
import AVFoundation

protocol ScannerVCDelegate : AnyObject {
    func didFind(barcode : String)
}

final class ScannerVC : UIViewController{
    
    let captureSession = AVCaptureSession()
    var previewLayer : AVCaptureVideoPreviewLayer?
    weak var scannerDelegate : ScannerVCDelegate?
    
    init(scannerDelegate : ScannerVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegate = scannerDelegate
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    private func setupCaptureSession(){
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        
        let videoInput : AVCaptureDeviceInput
        
        do{
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        if captureSession.canAddInput(videoInput){
            captureSession.addInput(videoInput)
        } else {
            return
        }
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput){
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13]
        } else {
            return
        }
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
}
extension ScannerVC : AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first else {return}
        guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else {return}
        guard let barcode = machineReadableObject.stringValue else {return}
        scannerDelegate?.didFind(barcode: barcode)
    }
    
}
