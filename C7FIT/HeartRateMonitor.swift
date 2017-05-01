//
//  HeartRateMonitor.swift
//  C7FIT
//
//  Created by Michael Lee on 4/27/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

// swiftlint:disable large_tuple
// swiftlint:disable cyclomatic_complexity
// swiftlint:disable function_body_length

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
    var changes = 0
    let settleFrames = 150.0
    var validFrameCounter = 0.0
    var timer = Timer()

    let lengthBeat = 20
    let maxPeriod = 1.5
    let minPeriod = 0.1
    let maxNumPeriod = 20

    var fingerOn = false

    let cameraSession = AVCaptureSession()
    // MARK: - Camera Capture

    func startCameraCapture() {
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

            let queue = DispatchQueue(label: "com.invasivecode.videoQueue")
            dataOutput.setSampleBufferDelegate(self, queue: queue)
            cameraSession.commitConfiguration()
            cameraSession.startRunning()
            UIApplication.shared.isIdleTimerDisabled = true

            self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateHeart), userInfo: nil, repeats: true)

        } catch let error as NSError {
            print("camera error:")
            print(error)
        }
    }

    func updateHeart() {
        let avgPeriod = getAvgPulses()
        if avgPeriod == -1 {
            print("fail")
        } else {
            let pulse = 60.0/avgPeriod
            print("RESULT")
            print(pulse)
            timer.invalidate()
            cameraSession.stopRunning()
            posIdx = 0
            negIdx = 0
            periodIndex = 0
            posPrevVals.removeAll()
            negPrevVals.removeAll()
            periods.removeAll()
            periodTimes.removeAll()

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

            // Check brightness high to tell if finger is placed over camera
            if sat > 0.5 && bright > 0.5 {

                self.validFrameCounter += 1

                let filterVal = filterValue(val: hue)

                if self.validFrameCounter > self.settleFrames {
                    detectChanges(val: filterVal, time: CACurrentMediaTime())
                }
                self.fingerOn = true
            } else {
                print("finger not over camera")
            }
        }
    }

    // MARK: - Pulse Calculation
    var posPrevVals = [CGFloat]()
    var posIdx = 0
    var negPrevVals = [CGFloat]()
    var negIdx = 0
    var pulses = 0.0

    func detectChanges(val: CGFloat, time: Double) {
        if val > 0 {
            self.greater += 1
            if posPrevVals.count <= lengthBeat {
                posPrevVals.append(val)
            } else {
                posPrevVals.insert(val, at: posIdx)
            }

            posIdx += 1
            if posIdx >= lengthBeat {
                posIdx = 0
            }
        } else if val <= 0 {
            self.lesser += 1
            if negPrevVals.count <= lengthBeat {
                negPrevVals.append(val)
            } else {
                negPrevVals.insert(val, at: negIdx)
            }

            negIdx += 1
            if negIdx >= lengthBeat {
                negIdx = 0
            }
        }
        var count: CGFloat = 0
        var total: CGFloat = 0
        for i in posPrevVals {
            count += 1
            total += i
        }

        let avgUp = total/count

        count = 0
        total = 0

        for i in negPrevVals {
            count += 1
            total += i
        }

        let avgDown = total/count

        if val < -0.5 * avgDown {
            lastVal = 0 // Down
        }

        if val > 0.5 * avgUp && lastVal == 0 {
            lastVal = 1 // Up state, need to change where this is?
            if time - periodStart < maxPeriod && time-periodStart > minPeriod {
                print("time-period")
                print(time-periodStart)
                if periods.count <= maxNumPeriod {
                    print("appending")
                    periods.append(time-periodStart)
                    periodTimes.append(time)
                } else {
                    print("inserting")
                    periods.insert(time-periodStart, at: periodIndex)
                    periodTimes.insert(time, at: periodIndex)
                }
                periodIndex += 1
                if periodIndex > maxNumPeriod {
                    periodIndex = 0
                }
            }
            periodStart = time
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

    var xvb = [CGFloat](repeating: 0, count: 13)
    var yvb = [CGFloat](repeating: 0, count: 13)

    func filterValue(val: CGFloat) -> CGFloat {
        let gain: CGFloat = 2.263280900

        xvb[0] = xvb[1]; xvb[1] = xvb[2]; xvb[2] = xvb[3]; xvb[3] = xvb[4]; xvb[4] = xvb[5]
        xvb[5] = xvb[6]; xvb[6] = xvb[7]; xvb[7] = xvb[8]; xvb[8] = xvb[9]; xvb[9] = xvb[10]
        xvb[10] =  val / gain
        yvb[0] = yvb[1]; yvb[1] = yvb[2]; yvb[2] = yvb[3]; yvb[3] = yvb[4]; yvb[4] = yvb[5]
        yvb[5] = yvb[6]; yvb[6] = yvb[7]; yvb[7] = yvb[8]; yvb[8] = yvb[9]; yvb[9] = yvb[10]
        yvb[10] =   (xvb[10] - xvb[0]) + 5 * (xvb[2] - xvb[8]) + 10 * (xvb[6] - xvb[4])
            + ( -0.0000000000 * yvb[0]) + (  0.0357796363 * yvb[1])
            + ( -0.1476158522 * yvb[2]) + (  0.3992561394 * yvb[3])
            + ( -1.1743136181 * yvb[4]) + (  2.4692165842 * yvb[5])
            + ( -3.3820859632 * yvb[6]) + (  3.9628972812 * yvb[7])
            + ( -4.3832594900 * yvb[8]) + (  3.2101976096 * yvb[9])
        return yvb[10]
    }

    var periods = [Double]()
    var periodStart = 0.0
    var periodTimes = [Double]()
    var periodIndex = 0

    func getAvgPulses() -> Double {
        let time = CACurrentMediaTime()
        var total = 0.0
        var count = 0.0
        if periods.count < self.maxNumPeriod {
            print(periods.count)
            return -1.0
        }
        for i in (0..<self.maxNumPeriod) {
            if time - periodTimes[i] < 10 {
                print("total")
                print(total)
                count += 1
                total += periods[i]
            } else {
            }
        }
        if count > 2 {
            return total/count
        } else {
            print("no count")
        }
        return -1.0
    }
}

extension CMSampleBuffer {
    func image(orientation: UIImageOrientation = .up, scale: CGFloat = 1.0) -> CIImage? {
        guard let buffer = CMSampleBufferGetImageBuffer(self) else { return nil }
        let ciImage = CIImage(cvPixelBuffer: buffer)
        return ciImage
    }
}
