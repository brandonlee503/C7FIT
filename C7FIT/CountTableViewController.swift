//
//  CountTableViewController.swift
//  C7FIT
//
//  Created by Michael Lee on 4/10/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class CountTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            // TODO: rename TimeCell
            let cell = TimeCell()
            cell.hourPicker.delegate = self
            cell.hourPicker.dataSource = self
            cell.minPicker.delegate = self
            cell.minPicker.dataSource = self
            return cell
        }
        return UITableViewCell()
    }


    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        }
        return 30
    }


}

extension CountTableViewController: TimePickerCellDataSource {
    public func numberOfComponents(in pickerView: UIPickerView, forCell cell: TimePickerSubCell) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int, forCell: TimePickerSubCell) -> Int {
        return 300
    }
}

extension CountTableViewController: TimePickerCellDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int, forCell cell: TimePickerSubCell) -> String? {
        let minOptions = 60
        let hourOptions = 24
        switch pickerView.tag {
        case 0:
            return String(row % hourOptions)
        case 1:
            return String(row % minOptions)
        default:
            return String(row)
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int, forCell cell: TimePickerSubCell) {
        return
    }
}
