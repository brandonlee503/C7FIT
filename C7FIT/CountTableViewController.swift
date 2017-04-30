//
//  CountTableViewController.swift
//  C7FIT
//
//  Created by Michael Lee on 4/10/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class CountTableViewController: UITableViewController {

    // MARK: - Constants

    let minOptions = 60
    let hourOptions = 24

    // MARK: - Properties

    var chosenHour = Int()
    var chosenMin = Int()
    var chosenTime = Double()
    var countTimer = Double()
    var currentTime = Double()
    var timer = Timer()
    var isTimeChosen = false

    // MARK: - Cells

    let buttonCell = GenLRButtonCell()
    let timerCell = TimerCell()

    // MARK: - View Life

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        self.buttonCell.leftButton.setTitle("Start", for: .normal)
        self.buttonCell.rightButton.setTitle("Stop", for: .normal)
        self.buttonCell.leftButton.backgroundColor = .orange
        self.buttonCell.rightButton.backgroundColor = .white
        self.buttonCell.rightButton.setTitleColor(.orange, for: .normal)

        self.buttonCell.leftButton.addTarget(self, action: #selector(startCount), for: .touchUpInside)
        self.buttonCell.rightButton.addTarget(self, action: #selector(stopCount), for: .touchUpInside)

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
            if isTimeChosen {
                return timerCell
            } else {
                // TODO: rename TimeCell
                let cell = TimeCell()
                cell.hourPicker.delegate = self
                cell.hourPicker.dataSource = self
                cell.minPicker.delegate = self
                cell.minPicker.dataSource = self
                return cell
            }
        } else if indexPath.row == 1 {
            return self.buttonCell
        }
        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 300
        }
        return 60
    }

    // MARK: - Button functions

    func startCount() {
        print("starting")
        self.chosenTime = (Double)(chosenHour * 3600 + chosenMin * 60)
        print(chosenTime)
        if chosenTime <= 0 {
            return
        }
        isTimeChosen = true
        self.timerCell.changeTime(time: getStringFromTime(time: self.chosenTime))
        tableView.reloadData()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        self.buttonCell.leftButton.removeTarget(nil, action: nil, for: .allEvents)
        self.buttonCell.leftButton.setTitle("Pause", for: .normal)
        self.buttonCell.leftButton.addTarget(self, action: #selector(pauseCount), for: .touchUpInside)
    }

    func stopCount() {
        print("stopping")
        isTimeChosen = false
        // Reset all Time variables
        self.currentTime = 0
        self.chosenTime = 0
        self.countTimer = 0
        self.chosenHour = 0
        self.chosenMin = 0
        tableView.reloadData()
        timer.invalidate()
        self.buttonCell.leftButton.removeTarget(nil, action: nil, for: .allEvents)
        self.buttonCell.leftButton.setTitle("Start", for: .normal)
        self.buttonCell.leftButton.addTarget(self, action: #selector(startCount), for: .touchUpInside)
    }

    func pauseCount() {
        print("pausing")
        self.timer.invalidate()
        self.buttonCell.leftButton.removeTarget(nil, action: nil, for: .allEvents)
        self.buttonCell.leftButton.setTitle("Unpause", for: .normal)
        self.buttonCell.leftButton.addTarget(self, action: #selector(unPauseCount), for: .touchUpInside)
    }

    func unPauseCount() {
        print("unpausing")
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        self.buttonCell.leftButton.removeTarget(nil, action: nil, for: .allEvents)
        self.buttonCell.leftButton.setTitle("Pause", for: .normal)
        self.buttonCell.leftButton.addTarget(self, action: #selector(pauseCount), for: .touchUpInside)
    }
    // MARK: - Timer

    func updateTimer() {
        self.countTimer += 1
        self.currentTime = chosenTime - countTimer

        let dispString = getStringFromTime(time: self.currentTime)

        if currentTime <= 0 {
            stopCount()
        } else {
            self.timerCell.changeTime(time: dispString)
        }
    }

    // MARK: - Helper

    func getStringFromTime(time: Double) -> String {
        let hour = floor(time/3600)
        let minute = floor(time/60).truncatingRemainder(dividingBy: 60)
        let second = time.truncatingRemainder(dividingBy: 60)

        return String(format:"%02i:%02i:%02i", Int(hour), Int(minute), Int(second))
    }
}

// MARK: - Picker Datasource and delegate

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
        switch pickerView.tag {
        case 0:
            chosenHour = row % hourOptions
        case 1:
            chosenMin = row % minOptions
        default:
            return
        }
    }
}
