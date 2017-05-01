//
//  ActivityViewController.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/22/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//
// swiftlint:disable cyclomatic_complexity

import UIKit

class ActivityViewController: UITableViewController {

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Activity"
        self.view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)

        tableView.delegate = self
        tableView.dataSource = self
    }

    init() {
        super.init(style: .grouped)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Mark: - Layout

    func setupConstraints() {
    }

    // MARK: UITableView Delegate and Datasource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
            return 1
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Today's Activity"
        case 1:
            return "Workout Tools"
        default:
            return "Activity Tracker"
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.textLabel?.text = "Today's Activity"
                cell.accessoryType = .disclosureIndicator
                return cell
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.textLabel?.text = "Stopwatch"
                cell.accessoryType = .disclosureIndicator
                return cell
            } else if indexPath.row == 1 {
                cell.textLabel?.text = "Countdown Timer"
                cell.accessoryType = .disclosureIndicator
                return cell
            } else if indexPath.row == 2 {
                cell.textLabel?.text = "Heartrate Calculator"
                cell.accessoryType = .disclosureIndicator
                return cell
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                cell.textLabel?.text = "Activity Tracker"
                cell.accessoryType = .disclosureIndicator
                return cell
            }
        }
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let destination = HealthKitTableViewController(style: UITableViewStyle.grouped)
                navigationController?.pushViewController(destination, animated: true)
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let destination = StopWatchTableViewController()
                navigationController?.pushViewController(destination, animated: true)
            } else if indexPath.row == 1 {
                let destination = CountTableViewController()
                navigationController?.pushViewController(destination, animated: true)
            } else if indexPath.row == 2 {
                let destination = HeartRateTableViewController(style: UITableViewStyle.grouped)
                navigationController?.pushViewController(destination, animated: true)
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                let destination = MapTableViewController()
                navigationController?.pushViewController(destination, animated: true)
            }
        }
    }

}
