//
//  ProfileViewController.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/22/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

// swiftlint:disable cyclomatic_complexity

import UIKit
import MobileCoreServices

private let profileIdentifier = "ProfileCell"
private let healthIdentifier = "HealthCell"
private let logoutIdentifier = "LogoutCell"

class ProfileViewController: UITableViewController {

    // MARK: - Constants

    let firebaseDataManager = FirebaseDataManager()

    // MARK: - Properties

    var userID: String?
    var user: User?
    var profileURL: URL?

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .orange
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: profileIdentifier)
        tableView.register(AbstractHealthCell.self, forCellReuseIdentifier: healthIdentifier)
        tableView.register(LogoutTableViewCell.self, forCellReuseIdentifier: logoutIdentifier)
        tableView.tableFooterView = UIView()

        // Add save button
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed))
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.rightBarButtonItem?.tintColor = .black

        // Monitor for user login/logout state
        firebaseDataManager.monitorLoginState { _, user in

            // If user is signed in, set userID else display login screen
            guard let userID = user?.uid else { return self.present(LoginViewController(), animated: true, completion: nil) }
            self.userID = userID
            print("state change, new user: \(userID)")

            // Create and build existing user
            self.firebaseDataManager.fetchUser(uid: userID) { data in
                guard let json = data.value as? [String: AnyObject] else { return }
                self.user = ProfileViewModel.buildExistingUser(json: json)

                if let urlString = self.user?.photoURL {
                    self.updateprofileImage(url: URL(string: urlString))
                } else {
                    self.updateprofileImage(url: nil)
                }

                self.tableView.reloadData()
            }
        }

        self.view.setNeedsUpdateConstraints()
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

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell: ProfileTableViewCell = tableView.dequeueReusableCell(withIdentifier: profileIdentifier) as? ProfileTableViewCell {
                cell.nameField.text = user?.name ?? ""
                cell.bioField.text = user?.bio ?? "Add a bio"
                cell.updateProfileButton.addTarget(self, action: #selector(updateProfilePicPressed(sender:)), for: .touchUpInside)
                return cell
            }
        case 1:
            if let weight = user?.weight {
                return healthCellHelper(title: "Weight (lbs)", value: weight, indexPath: indexPath)
            }
        case 2:
            if let height = user?.height {
                return healthCellHelper(title: "Height", value: height, indexPath: indexPath)
            }
        case 3:
            if let bmi = user?.bmi {
                return healthCellHelper(title: "BMI", value: bmi, indexPath: indexPath)
            }
        case 4:
            if let mileTime = user?.mileTime {
                return healthCellHelper(title: "Mile Time (minute, seconds)", value: mileTime, indexPath: indexPath)
            }
        case 5:
            if let pushups = user?.pushups {
                return healthCellHelper(title: "Pushups", value: pushups, indexPath: indexPath)
            }
        case 6:
            if let situps = user?.situps {
                return healthCellHelper(title: "Situps", value: situps, indexPath: indexPath)
            }
        case 7:
            if let legPress = user?.legPress {
                return healthCellHelper(title: "Leg Press", value: legPress, indexPath: indexPath)
            }
        case 8:
            if let benchPress = user?.benchPress {
                return healthCellHelper(title: "Bench Press", value: benchPress, indexPath: indexPath)
            }
        case 9:
            if let lateralPull = user?.lateralPull {
                return healthCellHelper(title: "Lateral Pull", value: lateralPull, indexPath: indexPath)
            }
        case 10:
            if let cell: LogoutTableViewCell = tableView.dequeueReusableCell(withIdentifier: logoutIdentifier) as? LogoutTableViewCell {
                return cell
            }
        default:
            break
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
                let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
                    let minuteField = timeAlert.textFields![0] as UITextField
                    let secondField = timeAlert.textFields![1] as UITextField
                    guard let minutes = minuteField.text, let seconds = secondField.text,
                        minutes != "", seconds != "" else { return }
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

    func healthCellHelper(title: String, value: String, indexPath: IndexPath) -> UITableViewCell {
        if let cell: AbstractHealthCell = tableView.dequeueReusableCell(withIdentifier: healthIdentifier) as? AbstractHealthCell {
            cell.dataTitle.text = title
            cell.dataLabel.text = value
            cell.inputView?.tag = indexPath.row
            return cell
        }

        return UITableViewCell()
    }

    // MARK: - User Interaction

    func logoutPressed() {
        firebaseDataManager.logout()
    }

    /**
        Pulls data from all client fields and updates user on server
     */
    // swiftlint:disable function_body_length
    func saveButtonPressed() {
        self.view.endEditing(true)
        var userDict = [String: String]()

        // Add profile attributes
        if let profilePic = self.profileURL?.absoluteString {
            userDict["profilePic"] = profilePic
        } else {
            userDict["profilePic"] = nil
        }

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
        let updatedUser = User(email: userEmail,
                                 photoURL: userDict["profilePic"],
                                 name: userDict["name"],
                                 bio: userDict["bio"],
                                 weight: userDict["weight"],
                                 height: userDict["height"],
                                 bmi: userDict["bmi"],
                                 mileTime: userDict["mileTime"],
                                 pushups: userDict["pushups"],
                                 situps: userDict["situps"],
                                 legPress: userDict["legPress"],
                                 benchPress: userDict["benchPress"],
                                 lateralPull: userDict["lateralPull"])
        firebaseDataManager.updateUser(uid: userID, user: updatedUser)

        // Display save alert
        let saveAlert = UIAlertController(title: "Data Saved", message: nil, preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Ok", style: .default)
        saveAlert.addAction(submitAction)
        self.present(saveAlert, animated: true, completion: nil)
    }
    // swiftlint:enable function_body_length

    /**
        Update BMI as user updates their weight/height
     */
    func updateBMI() {
        guard let weightCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? AbstractHealthCell,
            let heightCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? AbstractHealthCell
            else { return }
        guard let weight = weightCell.dataLabel.text, let height = heightCell.dataLabel.text else { return }
        let updatedBMI = ProfileViewModel.calculateBMI(weight: weight, height: height)
        if let cell = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? AbstractHealthCell {
            cell.dataLabel.text = updatedBMI
        }
    }

    /**
        Prompts user to select a new profile picture to upload
     */
    func updateProfilePicPressed(sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }

    /**
        Update the view's profile picture based on a firebase storage URL
        - Parameter url: User's profile picture URL
     */
    func updateprofileImage(url: URL?) {
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ProfileTableViewCell {
            if let url = url {
                cell.profileImageView.downloadImageFrom(url: url, imageMode: .scaleAspectFill)
            } else {
                cell.profileImageView.image = nil
            }
        }
    }
}
