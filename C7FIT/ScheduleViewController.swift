//
//  ScheduleViewController.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/22/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit
import MessageUI

private let scheduleIdentifier = "ScheduleCell"
private let bioIdentifier = "BioCell"
private let contactIdentifier = "ContactCell"

class ScheduleViewController: UITableViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {

    // MARK: - Constants

    let firebaseDataManager = FirebaseDataManager()

    // MARK: - Variables

    var scheduleURL: String?
    var clubBio: String?
    var clubEmail: String?
    var clubPhone: String?

    // MARK: - Initialization

    override init(style: UITableViewStyle) {
        super.init(style: style)
        firebaseDataManager.fetchClubInfo { data in
            guard let json = data.value as? [String: Any] else { return }
            self.scheduleURL = json["scheduleLink"] as? String
            self.clubBio = json["bio"] as? String
            self.clubEmail = json["email"] as? String
            self.clubPhone = json["phone"] as? String
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Schedule"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ScheduleCell.self, forCellReuseIdentifier: scheduleIdentifier)
        tableView.register(ClubBioCell.self, forCellReuseIdentifier: bioIdentifier)
        tableView.register(ClubContactCell.self, forCellReuseIdentifier: contactIdentifier)
        tableView.tableFooterView = UITableViewCell()
        view.backgroundColor = .white
        view.setNeedsUpdateConstraints()
    }

    // MARK: - UITableView Delegate and Datasource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let aspectRatioFirst: CGFloat = 1/2
        let aspectRatioSecond: CGFloat = 3/8
        let aspectRatioThird: CGFloat = 1/8
        let screenSize: CGRect = UIScreen.main.bounds
        let navBarSize: CGFloat? = self.navigationController?.navigationBar.frame.size.height
        let tabBarSize: CGFloat? = self.tabBarController?.tabBar.frame.size.height
        let statusBarSize: CGFloat? = UIApplication.shared.statusBarFrame.height
        let barConstants = screenSize.height - (navBarSize! + tabBarSize! + statusBarSize!)
        if indexPath.row < 1 {
            return aspectRatioFirst * barConstants
        } else if indexPath.row == 1 {
            return aspectRatioSecond * barConstants
        } else {
            return aspectRatioThird * barConstants
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: scheduleIdentifier) as? ScheduleCell {
                cell.scheduleButton.addTarget(self, action: #selector(self.scheduleLinkPressed), for: .touchUpInside)
                return cell
            }
        } else if indexPath.row == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: bioIdentifier) as? ClubBioCell {
                return cell
            }
        } else if indexPath.row == 2 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: contactIdentifier) as? ClubContactCell {
                cell.contactButton.addTarget(self, action: #selector(self.contactButtonPressed), for: .touchUpInside)
                return cell
            }
        }
        return UITableViewCell()
    }

    // MARK: - User Interaction

    func scheduleLinkPressed() {
        guard let scheduleURL = scheduleURL, let scheduleLink = URL(string: scheduleURL) else { return }
        UIApplication.shared.open(scheduleLink, options: [:], completionHandler: nil)
    }

    func contactButtonPressed() {
        print("contact button pressed")
        let contactGymAlert = UIAlertController(title: "Contact Us", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ -> Void in }
        let emailAction = UIAlertAction(title: "Email", style: .default, handler: { _ in
            print("email")
            self.sendEmail()
        })
        let textAction = UIAlertAction(title: "Text", style: .default, handler: { _ in
            print("text")
            self.sendText()
        })
        let callAction = UIAlertAction(title: "Call", style: .default, handler: { _ in
            print("Call")
            self.callGym()
        })

        contactGymAlert.addAction(cancelAction)
        contactGymAlert.addAction(emailAction)
        contactGymAlert.addAction(textAction)
        contactGymAlert.addAction(callAction)

        self.present(contactGymAlert, animated:true, completion:nil)
    }

    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let gymEmail = "infinitenl@gmail.com"
            let sampleBody = "<p>Testing text</p>"
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([gymEmail])
            mail.setMessageBody(sampleBody, isHTML: true)

            present(mail, animated: true, completion: nil)
        } else {
            print(MFMailComposeViewController.canSendMail())
            print("fail to open email box")
        }
    }

    func sendText() {
        if MFMessageComposeViewController.canSendText() {
            print("sending text")
            let gymPhone = "229929292"
            let sampleText = "what the"
            let message = MFMessageComposeViewController()

            message.body = sampleText
            message.recipients = [gymPhone]
            message.messageComposeDelegate = self
            present(message, animated: true, completion: nil)
        }

    }

    func callGym() {
        let gymPhone = "229929292"
        let phoneString = "tel://" + gymPhone
        let url = URL(string:phoneString)!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

}
