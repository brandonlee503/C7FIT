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

    // MARK: - Properties

    var activityView = ActivityView()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Activity"
        self.view.backgroundColor = .white

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(HealthKitTableViewCell.self, forCellReuseIdentifier: "HealthKitCell")
        tableView.register(MapTableViewCell.self, forCellReuseIdentifier: "MapCell")
        tableView.register(WatchTableViewCell.self, forCellReuseIdentifier: "WatchCell")
        tableView.register(CountTableViewCell.self, forCellReuseIdentifier: "CountCell")
        tableView.register(HeartRateTableViewCell.self, forCellReuseIdentifier: "HeartRateCell")
    }

    init() {
        super.init(style: .grouped)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Mark: - Layout

    func setupConstraints() {
        activityView.translatesAutoresizingMaskIntoConstraints = false
        let topView = activityView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomView = activityView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leftView = activityView.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightView = activityView.rightAnchor.constraint(equalTo: view.rightAnchor)
        NSLayoutConstraint.activate([topView, bottomView, leftView, rightView])
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
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                if let cell: HealthKitTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HealthKitCell") as? HealthKitTableViewCell {
                    return cell
                }
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                if let cell: WatchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WatchCell") as? WatchTableViewCell {
                    return cell
                }
            } else if indexPath.row == 1 {
                if let cell: CountTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CountCell") as? CountTableViewCell {
                    return cell
                }
            } else if indexPath.row == 2 {
                if let cell: HeartRateTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HeartRateCell") as? HeartRateTableViewCell {
                    return cell
                }
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                if let cell: MapTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MapCell") as? MapTableViewCell {
                    return cell
                }
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
