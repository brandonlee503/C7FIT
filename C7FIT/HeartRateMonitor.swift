//
//  HeartRateMonitor.swift
//  C7FIT
//
//  Created by Michael Lee on 4/27/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

// swiftlint:disable large_tuple

import UIKit
import Foundation
import AVFoundation
import CoreImage

class HeartRateMonitor: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {

    // MARK: - Properties

    var greater = 0
    var lesser = 0
    var lastVal = -1
    var switches = 0

    var fingerOn = false

    // MARK: - Camera Capture

    func startCameraCapture() {
        let cameraSession = AVCaptureSession()
        cameraSession.sessionPreset = AVCaptureSessionPresetMedium
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        do {
            try captureDevice?.lockForConfiguration()
            captureDevice?.torchMode = .on
            captureDevice?.unlockForConfiguration()
        } catch {
            print(error)
        }
        do {
            let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            cameraSession.beginConfiguration()

            if cameraSession.canAddInput(deviceInput) == true {
                cameraSession.addInput(deviceInput)
            } else {
                print("fail add input")
            }

            let dataOutput = AVCaptureVideoDataOutput()

            dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString):
                NSNumber(value: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange as UInt32)] // 3
            dataOutput.alwaysDiscardsLateVideoFrames = true

            if cameraSession.canAddOutput(dataOutput) == true {
                cameraSession.addOutput(dataOutput)
            } else {
                print("fail add output")
            }

            cameraSession.commitConfiguration()

            let queue = DispatchQueue(label: "com.invasivecode.videoQueue")
            dataOutput.setSampleBufferDelegate(self, queue: queue)

            cameraSession.startRunning()

            while fingerOn == false {
                sleep(1)
            }

            sleep(15)
            let changes = self.switches/2

            print(self.greater)
            print(self.lesser)
            print(changes * 4)
        } catch let error as NSError {
            print("camera error:")
            print(error)
        }
    }

    // Mark: - Capture Buffer delegate

    func captureOutput(_ captureOutput: AVCaptureOutput!,
                       didOutputSampleBuffer sampleBuffer: CMSampleBuffer!,
                       from connection: AVCaptureConnection!) {

        // Store Variable
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext()

        // Convert video output buffer usable image
        let colorImage = sampleBuffer.image()!

        // Use CIAreaAverage to get average color
        let extent = colorImage.extent
        let inputExtent = CIVector(x: extent.origin.x, y: extent.origin.y, z: extent.size.width, w: extent.size.height)
        let filter = CIFilter(name: "CIAreaAverage", withInputParameters: [kCIInputImageKey: colorImage, kCIInputExtentKey: inputExtent])!
        let outputImage = filter.outputImage!
        let outputExtent = outputImage.extent

        // Conversion Success
        if outputExtent.size.width == 1 && outputExtent.size.height == 1 {

            // Obtain our colors
            context.render(outputImage,
                           toBitmap: &bitmap,
                           rowBytes: 4,
                           bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
                           format: kCIFormatRGBA8,
                           colorSpace: CGColorSpaceCreateDeviceRGB())

            let red = CGFloat(bitmap[0]) / 255
            let green = CGFloat(bitmap[1]) / 255
            let blue = CGFloat(bitmap[2]) / 255
            let alpha = CGFloat(bitmap[3]) / 255

            // Convert to HSV values
            let (hue, sat, bright) = RGBtoHSV(red: red, green: green, blue: blue, alpha: alpha)
            print(hue)

            // Check brightness high to tell if finger is placed over camera
            if sat > 0.5 && bright > 0.5 {
                detectChanges(val: hue, time: 0.0)
                self.fingerOn = true
            } else {
                print("finger not over camera")
            }
        }
    }


    // MARK: - Pulse Calculation

    func detectChanges(val: CGFloat, time: Double) {
        print(val)
        if val > 0.1 {
            print("greater")
            self.greater += 1
            self.lastVal = 1
            if self.lastVal == -1 || self.lastVal == 0 {
                self.switches += 1
            }
        } else if val <= 0.1 {
            print("lesser")
            self.lesser += 1
            self.lastVal = 0
            if self.lastVal == -1 || self.lastVal == 1 {
                self.switches += 1
            }
        }
    }

    // MARK: - Helper functions

    func RGBtoHSV(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> (hue: CGFloat, sat: CGFloat, bright: CGFloat) {
        var hue: CGFloat = 0.0
        var sat: CGFloat = 0.0
        var bright: CGFloat = 0.0
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        color.getHue(&hue, saturation: &sat, brightness: &bright, alpha: nil)
        return (hue, sat, bright)
    }
}

extension CMSampleBuffer {
    func image(orientation: UIImageOrientation = .up, scale: CGFloat = 1.0) -> CIImage? {
        guard let buffer = CMSampleBufferGetImageBuffer(self) else { return nil }
        let ciImage = CIImage(cvPixelBuffer: buffer)
        return ciImage
    }
}
