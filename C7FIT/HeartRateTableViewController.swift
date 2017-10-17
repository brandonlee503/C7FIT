//
//  HeartRateTableViewController.swift
//  C7FIT
//
//  Created by Michael Lee on 4/12/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//
// swiftlint:disable cyclomatic_complexity
// swiftlint:disable body_length

import UIKit
import HealthKit
import AVFoundation
import CoreImage

class HeartRateTableViewController: UITableViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    let healthInfoID = "healthInfo"
    var healthKitManager = HealthKitManager()
    let heartRateMonitor = HeartRateMonitor()

    // MARK: - Properties

    var age: Int?
    var sex: String?
    var hrLow: Double = -1
    var hrHigh: Double = -1
    var hrMax: Double = -1

    // MARK: - View Life

    override func viewDidLoad() {
        super.viewDidLoad()
        healthKitManager.authorizeHealthKit()
        self.title = "Heart Rate"

        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(white: 0.9, alpha: 1.0)

        tableView.register(HealthInfoCell.self, forCellReuseIdentifier: healthInfoID)
        // TODO: - stretch goal heartRateMonitor.startCameraCapture()
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
                // Less than 0
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
                calcHeartRateModal()
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
            textMinutes.placeholder = "Heartbeats"
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
        
        // Disable selection of non-interactive cells
        if data.count > 0 {
            cell.selectionStyle = .none
        }
        
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

    func getHeartRate() {
        let heartAlert = UIAlertController(title: "Place and hold your finger over the Camera lens and Flashlight, and then press Ready",
                                           message: "", preferredStyle: .alert)
        let readyAction = UIAlertAction(title: "Ready", style: .default) { _ in
            self.heartRateMonitor.startCameraCapture()
            // TODO: - Update UI to show we're calculating?
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        heartAlert.addAction(readyAction)
        heartAlert.addAction(cancelAction)
        self.present(heartAlert, animated: true, completion: nil)
    }
}
