//
//  ProfileViewController.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/22/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {

    // MARK: - Constants
    
    let firebaseDataManager: FirebaseDataManager = FirebaseDataManager()
    
    // MARK: - Properties
    
    var userID: String?
    var user: User?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .orange
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileCell")
        tableView.register(AbstractHealthCell.self, forCellReuseIdentifier: "HealthCell")
        tableView.register(LogoutTableViewCell.self, forCellReuseIdentifier: "LogoutCell")
        tableView.tableFooterView = UIView()
        
        // Add save button
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed))
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        // Monitor for user login/logout state
        firebaseDataManager.monitorLoginState() { auth, user in
            
            // If user is signed in, set userID else display login screen
            guard let userID = user?.uid else { return self.present(LoginViewController(), animated: true, completion:nil) }
            self.userID = userID
            print("state change, new user: \(userID)")
            
            // Create and build existing user
            self.firebaseDataManager.fetchUser(uid: userID) { data in
                guard let json = data.value as? [String: AnyObject] else { return }
                self.user = ProfileViewModel.buildExistingUser(json: json)
                self.tableView.reloadData()
            }
        }
        
        self.view.setNeedsUpdateConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UITableView Delegate and Datasource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < 1 {
            return 150
        } else {
            return 50
        }
    }
    
    // FIXME: Lots of semi-repetitive code here.. Find a way to minimize if possible
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell: ProfileTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as? ProfileTableViewCell {
                cell.nameField.text = user?.name ?? ""
                cell.bioField.text = user?.bio ?? "Add a bio"
                return cell
            }
        } else if indexPath.row == 1 {
            if let cell: AbstractHealthCell = tableView.dequeueReusableCell(withIdentifier: "HealthCell") as? AbstractHealthCell {
                cell.dataTitle.text = "Weight (lbs)"
                if let weight = user?.weight {
                    cell.dataLabel.text = weight
                }
                cell.inputView?.tag = indexPath.row
                return cell
            }
        } else if indexPath.row == 2 {
            if let cell: AbstractHealthCell = tableView.dequeueReusableCell(withIdentifier: "HealthCell") as? AbstractHealthCell {
                cell.dataTitle.text = "Height"
                if let height = user?.height {
                    cell.dataLabel.text = height
                }
                cell.inputView?.tag = indexPath.row
                return cell
            }
        } else if indexPath.row == 3 {
            if let cell: AbstractHealthCell = tableView.dequeueReusableCell(withIdentifier: "HealthCell") as? AbstractHealthCell {
                cell.dataTitle.text = "BMI"
                // TODO: Pull Weight and height data and BMI math here
                if let bmi = user?.bmi {
                    cell.dataLabel.text = bmi
                }
                return cell
            }
        } else if indexPath.row == 4 {
            if let cell: AbstractHealthCell = tableView.dequeueReusableCell(withIdentifier: "HealthCell") as? AbstractHealthCell {
                cell.dataTitle.text = "Mile Time (minute, seconds)"
                if let mileTime = user?.mileTime {
                    cell.dataLabel.text = mileTime
                }
                cell.inputView?.tag = indexPath.row
                return cell
            }
        } else if indexPath.row == 5 {
            if let cell: AbstractHealthCell = tableView.dequeueReusableCell(withIdentifier: "HealthCell") as? AbstractHealthCell {
                cell.dataTitle.text = "Pushups"
                if let pushups = user?.pushups {
                    cell.dataLabel.text = pushups
                }
                cell.inputView?.tag = indexPath.row
                return cell
            }
        } else if indexPath.row == 6 {
            if let cell: AbstractHealthCell = tableView.dequeueReusableCell(withIdentifier: "HealthCell") as? AbstractHealthCell {
                cell.dataTitle.text = "Situps"
                if let situps = user?.situps {
                    cell.dataLabel.text = situps
                }
                cell.inputView?.tag = indexPath.row
                return cell
            }
        } else if indexPath.row == 7 {
            if let cell: AbstractHealthCell = tableView.dequeueReusableCell(withIdentifier: "HealthCell") as? AbstractHealthCell {
                cell.dataTitle.text = "Leg Press"
                if let legPress = user?.legPress {
                    cell.dataLabel.text = legPress
                }
                cell.inputView?.tag = indexPath.row
                return cell
            }
        } else if indexPath.row == 8 {
            if let cell: AbstractHealthCell = tableView.dequeueReusableCell(withIdentifier: "HealthCell") as? AbstractHealthCell {
                cell.dataTitle.text = "Bench Press"
                if let benchPress = user?.benchPress {
                    cell.dataLabel.text = benchPress
                }
                cell.inputView?.tag = indexPath.row
                return cell
            }
        } else if indexPath.row == 9 {
            if let cell: AbstractHealthCell = tableView.dequeueReusableCell(withIdentifier: "HealthCell") as? AbstractHealthCell {
                cell.dataTitle.text = "Lateral Pull"
                if let lateralPull = user?.lateralPull {
                    cell.dataLabel.text = lateralPull
                }
                cell.inputView?.tag = indexPath.row
                return cell
            }
        } else if indexPath.row == 10 {
            if let cell: LogoutTableViewCell = tableView.dequeueReusableCell(withIdentifier: "LogoutCell") as? LogoutTableViewCell {
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editableCells = [1, 2, 5, 6, 7, 8, 9]
        
        // If cell is one of the UIPickerView editable cells
        if editableCells.contains(indexPath.row) {
            if let cell = tableView.cellForRow(at: indexPath) as? AbstractHealthCell {
                cell.delegate = self
                cell.dataSource = self
                if !cell.isFirstResponder {
                    _ = cell.becomeFirstResponder()
                }
            }
        } else if indexPath.row == 4 {
            // Custom edit mile time
            if let cell = tableView.cellForRow(at: indexPath) as? AbstractHealthCell {
                let timeAlert = UIAlertController(title: "Enter Your Mile Time", message: nil, preferredStyle: .alert)
                let submitAction = UIAlertAction(title: "Submit", style: .default) { action in
                    let minuteField = timeAlert.textFields![0] as UITextField
                    let secondField = timeAlert.textFields![1] as UITextField
                    guard let minutes = minuteField.text, let seconds = secondField.text, minutes != "", seconds != "" else { return }
                    cell.dataLabel.text = "\(minutes):\(seconds)"
                    self.dismiss(animated: true, completion: nil)
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                
                timeAlert.addTextField { textMinutes in
                    textMinutes.placeholder = "Minutes"
                    textMinutes.keyboardType = .numberPad
                }
                
                timeAlert.addTextField { textSeconds in
                    textSeconds.placeholder = "Seconds"
                    textSeconds.keyboardType = .numberPad
                }
                
                timeAlert.addAction(submitAction)
                timeAlert.addAction(cancelAction)
                self.present(timeAlert, animated: true, completion: nil)
            }
        } else if indexPath.row == 10 {
            // Logout user
            logoutPressed()
        }
        
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - User Interaction
    
    /**
        Pulls data from all client fields and updates user on server
     */
    // TODO: Make this better if possible...
    func saveButtonPressed() {
        self.view.endEditing(true)
        var userDict = [String: String]()
        
        // Add profile attributes
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ProfileTableViewCell {
            userDict["name"] = cell.nameField.text
            userDict["bio"] = cell.bioField.text
        }
        
        // Add health attributes
        for row in 1...9 {
            if let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? AbstractHealthCell {
                switch row {
                case 1:
                    userDict["weight"] = cell.dataLabel.text
                case 2:
                    userDict["height"] = cell.dataLabel.text
                case 3:
                    userDict["bmi"] = cell.dataLabel.text
                case 4:
                    userDict["mileTime"] = cell.dataLabel.text
                case 5:
                    userDict["pushups"] = cell.dataLabel.text
                case 6:
                    userDict["situps"] = cell.dataLabel.text
                case 7:
                    userDict["legPress"] = cell.dataLabel.text
                case 8:
                    userDict["benchPress"] = cell.dataLabel.text
                case 9:
                    userDict["lateralPull"] = cell.dataLabel.text
                default:
                    break
                }
            }
        }
        
        // Build new user and send update
        guard let userID = self.userID, let userEmail = self.user?.email else { return }
        let updatedUser: User = User(email: userEmail, photoURL: nil, name: userDict["name"], bio: userDict["bio"], weight: userDict["weight"], height: userDict["height"], bmi: userDict["bmi"], mileTime: userDict["mileTime"], pushups: userDict["pushups"], situps: userDict["situps"], legPress: userDict["legPress"], benchPress: userDict["benchPress"], lateralPull: userDict["lateralPull"])
        firebaseDataManager.updateUser(uid: userID, user: updatedUser)
    }
    
    func logoutPressed() {
        firebaseDataManager.logout()
    }
}

// MARK: - PickerCellDelegate

/// Adapter Pattern for UIPickerView and UITableViewCells
extension ProfileViewController: PickerCellDelegate {
    func onPickerOpen(_ cell: AbstractHealthCell) {
        switch cell.picker.tag {
        case 1:
            cell.dataLabel.text = cell.dataLabel.text!.isEmpty ? ProfileViewModel.personalWeight[0] : cell.dataLabel.text
        case 2:
            cell.dataLabel.text = cell.dataLabel.text!.isEmpty ? ProfileViewModel.personalHeight[0] : cell.dataLabel.text
        case 5, 6:
            cell.dataLabel.text = cell.dataLabel.text!.isEmpty ? ProfileViewModel.repetitions[0] : cell.dataLabel.text
        case 7, 8, 9:
            cell.dataLabel.text = cell.dataLabel.text!.isEmpty ? ProfileViewModel.weights[0] : cell.dataLabel.text
        default:
            break
        }
        cell.dataLabel.textColor = .red
    }
    
    func onPickerClose(_ cell: AbstractHealthCell) {
        cell.dataLabel.textColor = .black
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int, forCell cell: AbstractHealthCell) -> String? {
        switch pickerView.tag {
        case 1:
            return ProfileViewModel.personalWeight[row]
        case 2:
            return ProfileViewModel.personalHeight[row]
        case 5, 6:
            return ProfileViewModel.repetitions[row]
        case 7, 8, 9:
            return ProfileViewModel.weights[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int, forCell cell: AbstractHealthCell) {
        switch pickerView.tag {
        case 1:
            cell.dataLabel.text = ProfileViewModel.personalWeight[row]
        case 2:
            cell.dataLabel.text = ProfileViewModel.personalHeight[row]
        case 5, 6:
            cell.dataLabel.text = ProfileViewModel.repetitions[row]
        case 7, 8, 9:
            cell.dataLabel.text = ProfileViewModel.weights[row]
        default:
            break
        }
    }
}

// MARK: - PickerCellDataSource

extension ProfileViewController: PickerCellDataSource {
    public func numberOfComponents(in pickerView: UIPickerView, forCell cell: AbstractHealthCell) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int, forCell: AbstractHealthCell) -> Int {
        switch pickerView.tag {
        case 1:
            return ProfileViewModel.personalWeight.count
        case 2:
            return ProfileViewModel.personalHeight.count
        case 5, 6:
            return ProfileViewModel.repetitions.count
        case 7, 8, 9:
            return ProfileViewModel.weights.count
        default:
            return 0
        }
    }
}
