//
//  StopWatchTableViewController.swift
//  C7FIT
//
//  Created by Michael Lee on 4/2/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class StopWatchTableViewController: UITableViewController {
    
    // MARK: - Identifiers
    
    let timerCellID = "timerCell"
    let buttonCellID = "buttonCell"
    let lapCellID = "lapCell"
    
    // MARK: - Properties
    
    let buttonCell = WatchButtonCell()
    let timerCell = WatchTimerCell()
    
    lazy var startTime = 0.0
    lazy var timer = Timer()
    lazy var time = 0.0
    lazy var prevTime = 0.0
    
    lazy var lapData = [String]()

    // MARK: - Initialization
    
    override func viewDidLoad() {
        print("viewdidload")
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        tableView.register(RunListCell.self, forCellReuseIdentifier: lapCellID)
        
        buttonCell.startStopButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        buttonCell.lapResetButton.addTarget(self, action: #selector(createLap), for: .touchUpInside)
        
    }

    // MARK: - Timer function
    
    func startTimer() {
        print("starting")
        self.buttonCell.startStopButton.removeTarget(nil, action: nil, for: .allEvents)
        self.buttonCell.startStopButton.setTitle("Pause", for: .normal)
        self.buttonCell.startStopButton.addTarget(self, action: #selector(pauseTimer), for: .touchUpInside)
        
        self.buttonCell.lapResetButton.removeTarget(nil, action: nil, for: .allEvents)
        self.buttonCell.lapResetButton.setTitle("Lap", for: .normal)
        self.buttonCell.lapResetButton.addTarget(self, action: #selector(createLap), for: .touchUpInside)
        
        self.startTime = Date().timeIntervalSinceReferenceDate
        self.timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func pauseTimer() {
        print("pausing")
        self.prevTime = time
        self.buttonCell.startStopButton.removeTarget(nil, action: nil, for: .allEvents)
        self.buttonCell.startStopButton.setTitle("Start", for: .normal)
        self.buttonCell.startStopButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        
        self.buttonCell.lapResetButton.removeTarget(nil, action: nil, for: .allEvents)
        self.buttonCell.lapResetButton.setTitle("Reset", for: .normal)
        self.buttonCell.lapResetButton.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
        
        self.timer.invalidate()
    }
    
    func createLap() {
        print("lapping")
        
        let dispTime = String(format:"%02d:%02d.%02d", (Int)(time/60), (Int)((time).truncatingRemainder(dividingBy: 60)), (Int)((time*100).truncatingRemainder(dividingBy: 100)) )
        self.lapData.append(dispTime)
        self.tableView.reloadData()
    }
    
    func resetTimer() {
        print("resetting")
        self.buttonCell.lapResetButton.removeTarget(nil, action: nil, for: .allEvents)
        self.buttonCell.lapResetButton.setTitle("Lap", for: .normal)
        self.buttonCell.lapResetButton.addTarget(self, action: #selector(createLap), for: .touchUpInside)
        
        //reset the timer
        //should already be stopped by "pause", so timer.invalidate already called
        self.time = 0.0
        self.prevTime = 0.0
        self.lapData.removeAll()
        self.timerCell.changeTime(min: "00", sec: "00", ms: "00")
        
        //add in
        self.timer.invalidate()
        //clear the rows
        self.tableView.reloadData()
    }
    
    func updateTimer() {
        self.time = prevTime + Date().timeIntervalSinceReferenceDate - startTime
        
        let dispMin = String(format:"%02d", (Int)(time/60))
        let dispSec = String(format:"%02d", (Int)((time).truncatingRemainder(dividingBy: 60)) )
        let dispMs = String(format:"%02d", (Int)((time*100).truncatingRemainder(dividingBy: 100)) )
        
        self.timerCell.changeTime(min: dispMin, sec: dispSec, ms: dispMs)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section
        {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return lapData.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            //timer
            let cell = self.timerCell
            return cell
        case 1:
            //start stop buttons
            let cell = self.buttonCell
            return cell
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: lapCellID, for: indexPath) as? RunListCell {
                
                cell.titleLabel.text = "Lap " + String(indexPath.row)
                cell.valLabel.text = self.lapData[indexPath.row]
                
                return cell
            }
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight: CGFloat = 40.0
        
        if(indexPath.section == 0 && indexPath.row == 0) {
            return cellHeight * 6
        }
        return cellHeight
    }

}
