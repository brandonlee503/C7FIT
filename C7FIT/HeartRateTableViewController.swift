//
//  HeartRateTableViewController.swift
//  C7FIT
//
//  Created by Michael Lee on 4/12/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit
import HealthKit

class HeartRateTableViewController: UITableViewController {

    let healthInfoID = "healthInfo"
    var healthKitManager = HealthKitManager()

    // MARK :- Properties
    var age: Int?
    var sex: String?

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
            return 3
        default:
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return ""
        case 1:
            return "Target Heart Rate"
        default:
            return "Other Statistics"
        }
    }

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
            switch indexPath.row {
            case 0:
                let sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)
                let titleLabel = "Resting"
                return queryData(titleLabel: titleLabel, sampleType: sampleType!)
            case 1:
                let sampleType = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
                let titleLabel = "Steps Walked"
                return queryData(titleLabel: titleLabel, sampleType: sampleType!)
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

}
