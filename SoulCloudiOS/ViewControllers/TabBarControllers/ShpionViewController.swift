//
//  ShpionViewController.swift
//  SoulCloudiOS
//
//  Created by Damir Zaripov on 06.04.2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


class ShpionViewController: UIViewController {
    
    @IBOutlet weak var cameraPreview: UIView!
    var session: AVCaptureSession?
    var input: AVCaptureDeviceInput?
    var output: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraPreview.isHidden = true
        //Initialize session an output variables this is necessary
        session = AVCaptureSession()
        output = AVCaptureStillImageOutput()
        let camera = getDevice(position: .front)
        do {
            input = try AVCaptureDeviceInput(device: camera!)
        } catch let error as NSError {
            print(error)
            input = nil
        }
        
        if(session?.canAddInput(input!) == true){
            session?.addInput(input!)
            output?.outputSettings = [AVVideoCodecKey : AVVideoCodecType.jpeg]
            if(session?.canAddOutput(output!) == true){
                session?.addOutput(output!)
                previewLayer = AVCaptureVideoPreviewLayer(session: session!)
                previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
                previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                previewLayer?.frame = cameraPreview.bounds
                cameraPreview.layer.addSublayer(previewLayer!)
                //                let focusMode:AVCaptureDevice.FocusMode = .autoFocus
                //                if (camera?.isFocusModeSupported(focusMode))! {
                //                    try! camera?.lockForConfiguration()
                //                    camera?.focusMode = focusMode
                //                    try! camera?.unlockForConfiguration()
                //                }
                //
                //
                //                var incandescentLightCompensation = 3_000
                //                var tint = 0 // no shift
                //                let temperatureAndTintValues = AVCaptureDevice.WhiteBalanceTemperatureAndTintValues(temperature: Float(incandescentLightCompensation), tint: Float(tint))
                //                var deviceGains = camera?.deviceWhiteBalanceGains(for: temperatureAndTintValues)
                //                try! camera?.lockForConfiguration()
                //                camera?.setWhiteBalanceModeLocked(with: deviceGains!) {
                //                    (timestamp:CMTime) -> Void in
                //                }
                //                try! camera?.unlockForConfiguration()
                session?.startRunning()
            
                
                Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { (timer) in
                    let connetciton = self.output?.connection(with: AVMediaType.video)
                    self.output?.captureStillImageAsynchronously(from: connetciton!, completionHandler: { (buffer, error) in
                        
                        
                        let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(buffer!)
                        print(imageData!)
                        let test2 = imageData?.base64EncodedString()
                        print(test2)
                        UIImageWriteToSavedPhotosAlbum(UIImage(data: imageData!)!, nil, nil, nil)
                    })
                })
                
            }
        }
    }
  
    //Get the device (Front or Back)
    func getDevice(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let devices: NSArray = AVCaptureDevice.devices() as NSArray;
        for de in devices {
            let deviceConverted = de as! AVCaptureDevice
            if(deviceConverted.position == position){
                return deviceConverted
            }
        }
        return nil
    }
}
