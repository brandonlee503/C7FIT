//
//  HeartRateTableViewController.swift
//  C7FIT
//
//  Created by Michael Lee on 4/12/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//
// swiftlint:disable cyclomatic_complexity
import UIKit
import HealthKit
import AVFoundation
import CoreImage

class HeartRateTableViewController: UITableViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    let healthInfoID = "healthInfo"
    var healthKitManager = HealthKitManager()

    // MARK :- Properties
    var age: Int?
    var sex: String?
    var hrLow: Double = -1
    var hrHigh: Double = -1
    var hrMax: Double = -1
    var validFrameCounter: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        healthKitManager.authorizeHealthKit()
        self.title = "Heart Rate"

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(HealthInfoCell.self, forCellReuseIdentifier: healthInfoID)

    }

    override init(style: UITableViewStyle) {
        super.init(style: style)
        queryAttributes()
        calcTargetHeartRates()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 2
        default:
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "User Information"
        case 1:
            if age != nil {
                return String(format:"Target Heart Rate For %d Years", age!)
            } else {
                return "Target Heart Rate"
            }
        default:
            return "Calculate Heart Rate"
        }
    }

    // swiftlint:disable:next function_body_length
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let titleLabel = "Age"
                if self.age != nil {
                    return cellAttribute(titleLabel: titleLabel, data: String(describing: age!))
                } else {
                    return cellAttribute(titleLabel: titleLabel, data: "N/A")
                }
            case 1:
                let titleLabel = "Sex"
                if self.sex != nil {
                    return cellAttribute(titleLabel: titleLabel, data: self.sex!)
                } else {
                    return cellAttribute(titleLabel: titleLabel, data: "N/A")
                }
            default:
                break
            }
        case 1:
            var midLabel = String()
            var maxLabel = String()
            if self.hrLow > 0 {
                midLabel = String(format:"%.0f - %.0f", self.hrLow, self.hrHigh)
                maxLabel = String(format:"%.0f", self.hrMax)
            } else {
                print("less than 0")
                midLabel = "N/A"
                maxLabel = "N/A"
            }
            switch indexPath.row {
            case 0:
                let titleLabel = "Moderate Physical Activity"
                return cellAttribute(titleLabel: titleLabel, data: midLabel)
            case 1:
                let titleLabel = "Maximum Physical Acitivty"
                return cellAttribute(titleLabel: titleLabel, data: maxLabel)
            default:
                break
            }
        case 2:
            let titleLabel = "Calculate"
            return cellAttribute(titleLabel: titleLabel, data: "")
        default:
            break
        }

        if let cell: HealthInfoCell = tableView.dequeueReusableCell(withIdentifier: healthInfoID, for: indexPath) as? HealthInfoCell {
            return cell
        }

        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            if indexPath.row == 0 {
//                calcHeartRateModal()
                startCameraCapture()
            }
        }
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - cell functions

    func calcHeartRateModal() {
        // Create modal alert
        let heartAlert = UIAlertController(title: "", message: "Count the number of heartbeats for 10 seconds", preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
            let numBeats = heartAlert.textFields![0] as UITextField

            if var heartRate = Double(numBeats.text!) {
                // Calc heartrate
                heartRate *= 6
                self.heartRateResultModal(heartRate: heartRate)
                return

            } else {
                self.heartRateResultModal(heartRate: -1)
                return
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        // Alert field
        heartAlert.addTextField { textMinutes in
            textMinutes.placeholder = "run name"
            textMinutes.keyboardType = .numberPad
        }

        // Display modal
        heartAlert.addAction(submitAction)
        heartAlert.addAction(cancelAction)
        self.present(heartAlert, animated: true, completion: nil)
    }

    func heartRateResultModal(heartRate: Double) {
        var title: String = ""
        var message: String = ""
        if heartRate > 0 {
            title = String(format:"Heart Rate: %.0fbpm", heartRate)
            if heartRate < self.hrMax {
                let exertionPercent: Double = heartRate/self.hrHigh
                if exertionPercent > 0.69 {
                    message = "Your heart rate matches intense physical excercise"
                } else if exertionPercent > 0.5 {
                    message = "Your heart rate matches moderate physical excercise"
                } else if exertionPercent < 0.5 {
                    message = "Your heart rate matches light physical excercise"
                }
            } else {
                message = "Your heart rate was greater than target maximum"
            }
        } else {
            title = "Error"
            message = "Could not calculate Heart Rate"
        }
        let heartResult = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "okay", style: .cancel)
        heartResult.addAction(ok)
        self.present(heartResult, animated: true, completion:nil)
    }

    func queryData(titleLabel: String, sampleType: HKSampleType) -> HealthInfoCell {
        let cell = HealthInfoCell()
        cell.titleLabel.text = titleLabel

        self.healthKitManager.queryUserData(sampleType: sampleType, completion : { (mostRecentVal, error) -> Void in
            if error != nil {
                print("Error")
                return
            }

            let result = mostRecentVal as! HKQuantitySample
            DispatchQueue.main.async {
                // TODO: find better way to format info label
                cell.infoLabel.text = String(result.quantity.description)
            }
        })
        return cell
    }

    func queryAttributes() {
        let (qAge, qSex) = healthKitManager.getAgeSex()
        self.age = qAge

        if qSex != nil {
            switch qSex!.biologicalSex.rawValue {
            case 1:
                self.sex = "Female"
            case 2:
                self.sex = "Male"
            case 3:
                self.sex = "Other"
            default:
                self.sex = "N/A"
            }
        } else {
            self.sex = nil
        }
    }

    func cellAttribute(titleLabel: String, data: String) -> HealthInfoCell {
        let cell = HealthInfoCell()
        cell.titleLabel.text = titleLabel
        cell.infoLabel.text = data
        return cell
    }

    func calcTargetHeartRates() {
        if age != nil {
            let curAge = age!
            let targets = HeartRateTargets()
            if curAge <= 25 {
                (self.hrLow, self.hrHigh, self.hrMax) = targets.beatZone[20]!
            } else if curAge > 25 && curAge <= 34 {
                (self.hrLow, self.hrHigh, self.hrMax) = targets.beatZone[30]!
            } else if curAge > 34 && curAge <= 38 {
                (self.hrLow, self.hrHigh, self.hrMax) = targets.beatZone[35]!
            } else if curAge > 38 && curAge <= 43 {
                (self.hrLow, self.hrHigh, self.hrMax) = targets.beatZone[40]!
            } else if curAge > 43 && curAge <= 48 {
                (self.hrLow, self.hrHigh, self.hrMax) = targets.beatZone[45]!
            } else if curAge > 48 && curAge <= 53 {
                (self.hrLow, self.hrHigh, self.hrMax) = targets.beatZone[50]!
            } else if curAge > 53 && curAge <= 58 {
                (self.hrLow, self.hrHigh, self.hrMax) = targets.beatZone[55]!
            } else if curAge > 58 && curAge <= 63 {
                (self.hrLow, self.hrHigh, self.hrMax) = targets.beatZone[60]!
            } else if curAge > 63 && curAge <= 70 {
                (self.hrLow, self.hrHigh, self.hrMax) = targets.beatZone[65]!
            } else if curAge > 70 {
                (self.hrLow, self.hrHigh, self.hrMax) = targets.beatZone[70]!
            }

            // TODO: - we can remove targets and just use math 220-age = max
            self.hrMax = 220 - Double(curAge)
            return
        }
    }

    let heartRateMonitor = HeartRateMonitor()

    func getHeartRate() {
        heartRateMonitor.startCameraCapture()
    }

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

            sleep(20)

            print(self.greater)
            print(self.lesser)
            print(self.switches/2)
        } catch let error as NSError {
            print("camera error:")
            print(error)
        }
    }

    func captureOutput(_ captureOutput: AVCaptureOutput!,
                       didOutputSampleBuffer sampleBuffer: CMSampleBuffer!,
                       from connection: AVCaptureConnection!) {
        print("doing capture")
        // Calc avg rgb value
        let colorImage = sampleBuffer.image()!
        let extent = colorImage.extent
        let inputExtent = CIVector(x: extent.origin.x, y: extent.origin.y, z: extent.size.width, w: extent.size.height)
        let filter = CIFilter(name: "CIAreaAverage", withInputParameters: [kCIInputImageKey: colorImage, kCIInputExtentKey: inputExtent])!
        let outputImage = filter.outputImage!
        let outputExtent = outputImage.extent
        assert(outputExtent.size.width == 1 && outputExtent.size.height == 1)
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext()
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

        // Finger is placed over camera?
        if sat > 0.5 && bright > 0.5 {
            addValue(val: hue, time: 0.0)
        } else {
            print("finger not over camera")
        }
    }

    var greater = 0
    var lesser = 0
    var lastVal = -1
    var switches = 0

    func addValue(val: CGFloat, time: Double) -> CGFloat {
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
        return 0.0
    }

    func blink() {

    }

    func RGBtoHSV(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> (hue: CGFloat, sat: CGFloat, bright: CGFloat) {
        var hue: CGFloat = 0.0
        var sat: CGFloat = 0.0
        var bright: CGFloat = 0.0
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        color.getHue(&hue, saturation: &sat, brightness: &bright, alpha: nil)
        return (hue, sat, bright)
    }
}

//extension CMSampleBuffer {
//    func image(orientation: UIImageOrientation = .up, scale: CGFloat = 1.0) -> CIImage? {
//        guard let buffer = CMSampleBufferGetImageBuffer(self) else { return nil }
//
//        let ciImage = CIImage(cvPixelBuffer: buffer)
//
//        return ciImage
//    }
//}
