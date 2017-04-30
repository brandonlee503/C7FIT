//
//  HealthKitTableViewController.swift
//  C7FIT
//
//  Created by Michael Lee on 3/31/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

// swiftlint:disable cyclomatic_complexity
// swiftlint:disable function_body_length

import UIKit
import HealthKit

class HealthKitTableViewController: UITableViewController {

    let healthInfoID = "healthInfo"
    var healthKitManager = HealthKitManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        healthKitManager.authorizeHealthKit()
        self.title = "Today's Activity"

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HealthInfoCell.self, forCellReuseIdentifier: healthInfoID)

    }

    override init(style: UITableViewStyle) {
        super.init(style: style)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return 2
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Health Statistics"
        case 1:
            return "Recent Activity"
        default:
            return "Other Statistics"
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)
                let titleLabel = "Weight"
                return queryData(titleLabel: titleLabel, sampleType: sampleType!, path: indexPath)
            case 1:
                let sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)
                let titleLabel = "Height"
                return queryData(titleLabel: titleLabel, sampleType: sampleType!, path: indexPath)
            case 2:
                let sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMassIndex)
                let titleLabel = "BMI"
                return queryData(titleLabel: titleLabel, sampleType: sampleType!, path: indexPath)
            case 3:
                let sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyFatPercentage)
                let titleLabel = "Body Fat Percentage"
                return queryData(titleLabel: titleLabel, sampleType: sampleType!, path: indexPath)
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                let sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)
                let titleLabel = "Latest Distance Ran"
                return queryData(titleLabel: titleLabel, sampleType: sampleType!, path: indexPath)
            case 1:
                let sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
                let titleLabel = "Steps Walked"
                return queryData(titleLabel: titleLabel, sampleType: sampleType!, path: indexPath)
            default:
                break
            }
        default:
            break
        }

        if let cell: HealthInfoCell = tableView.dequeueReusableCell(withIdentifier: healthInfoID, for: indexPath) as? HealthInfoCell {
            return cell
        }

        return UITableViewCell()
    }

    func queryData(titleLabel: String, sampleType: HKSampleType, path: IndexPath) -> HealthInfoCell {
        let cell = HealthInfoCell()
        cell.titleLabel.text = titleLabel

        self.healthKitManager.queryUserData(sampleType: sampleType, completion : { (mostRecentVal, error) -> Void in
            if error != nil {
                print("Error")
                return
            }
            if let result = mostRecentVal as? HKQuantitySample {
                DispatchQueue.main.async {
                    var labelHK: HKQuantity?
                    if path.section == 0 {
                        switch path.row {
                        case 0:
                            // Weight
                            labelHK = HKQuantity(unit: HKUnit.pound(),
                                                 doubleValue: RunData.roundDouble(double: result.quantity.doubleValue(for: HKUnit.pound()), round: 2))
                            break
                        case 1:
                            // Height
                            labelHK = HKQuantity(unit: HKUnit.foot(),
                                                 doubleValue: RunData.roundDouble(double: result.quantity.doubleValue(for: HKUnit.foot()), round: 2))
                            break
                        case 2:
                            // BMI
                            labelHK = HKQuantity(unit: HKUnit.count(), doubleValue: result.quantity.doubleValue(for: HKUnit.count()))
                            break
                        case 3:
                            // Body Fat %
                            labelHK = HKQuantity(unit: HKUnit.percent(), doubleValue: result.quantity.doubleValue(for: HKUnit.percent()))
                            break
                        default:
                            labelHK = nil
                            break
                        }
                    } else if path.section == 1 {
                        switch path.row {
                        case 0:
                            // Distance Ran
                            labelHK = HKQuantity(unit: HKUnit.mile(),
                                                 doubleValue: RunData.roundDouble(double: result.quantity.doubleValue(for: HKUnit.mile()), round: 2))
                            break
                        case 1:
                            // Step Count
                            labelHK = HKQuantity(unit: HKUnit.count(),
                                                 doubleValue: RunData.roundDouble(double: result.quantity.doubleValue(for: HKUnit.count()), round: 2))
                            break
                        default:
                            labelHK = nil
                            break
                        }
                    }
                    if let lhk = labelHK {
                        cell.infoLabel.text = String(lhk.description)
                    }
                }
            }
        })
        return cell
    }

}
