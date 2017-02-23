//
//  ScheduleViewController.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/22/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit
import MessageUI

class ScheduleViewController: UITableViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    // MARK: - Properties
    
    var scheduleView = ScheduleView()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Schedule"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .orange
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ScheduleBrowserTableViewCell.self, forCellReuseIdentifier: "BrowserLinkCell")
   
        tableView.register(ScheduleBioTableViewCell.self, forCellReuseIdentifier: "BioCell")
        tableView.register(ScheduleContactTableViewCell.self, forCellReuseIdentifier: "ContactCell")
        
        if(tableView.contentSize.height < tableView.frame.size.height) {
            tableView.isScrollEnabled = false;
        } else {
            tableView.isScrollEnabled = true;
        }

        self.view.addSubview(scheduleView)
        setupConstraints()
        self.view.setNeedsUpdateConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Layout
    
    func setupConstraints() {        
        scheduleView.translatesAutoresizingMaskIntoConstraints = false
        let topView = scheduleView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomView = scheduleView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leftView = scheduleView.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightView = scheduleView.rightAnchor.constraint(equalTo: view.rightAnchor)
        NSLayoutConstraint.activate([topView, bottomView, leftView, rightView])
    }
    
    // MARK: UITableView Delegate and Datasource
    
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
        let screenSize : CGRect = UIScreen.main.bounds
        //use optionals here
        //self.navigationController?...
        let navBarSize : CGFloat? = self.navigationController?.navigationBar.frame.size.height
        let tabBarSize : CGFloat? = self.tabBarController?.tabBar.frame.size.height
        let statusBarSize: CGFloat? = UIApplication.shared.statusBarFrame.height
        let barConstants = screenSize.height - (navBarSize! + tabBarSize! + statusBarSize!)
        if indexPath.row < 1 {
            return aspectRatioFirst * barConstants
        } else if indexPath.row == 1 {
            return aspectRatioSecond * barConstants //clean this up later if want different
        } else {
            return aspectRatioThird * barConstants //clean this up later if want different
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell: ScheduleBrowserTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BrowserLinkCell") as? ScheduleBrowserTableViewCell {
                cell.scheduleLink.addTarget(self, action: #selector(self.scheduleLinkPressed), for: .touchUpInside)
                return cell
            }
        } else if indexPath.row == 1 {
            if let cell: ScheduleBioTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BioCell") as? ScheduleBioTableViewCell {
                return cell
            }
        } else if indexPath.row == 2 {
            if let cell: ScheduleContactTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ContactCell") as? ScheduleContactTableViewCell  {
                cell.contactButton.addTarget(self, action: #selector(self.contactButtonPressed), for: .touchUpInside)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    // MARK: - Cell Functions
    // MARK: BrowserCell Link Function
    
    func scheduleLinkPressed() {
        print("scheduleLinkPressed")
        if let linkUrl = URL(string: "http:clubsevenfitness.com") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(linkUrl, options: [:],
                                          completionHandler: {
                                            (success) in
                                            print("Open \(success)")
                })
            } else {
                let success = UIApplication.shared.openURL(linkUrl)
                print("Open \(success)")
            }
        }
    }
    
    
    //MARK: ContactCell Button Function
    func contactButtonPressed() {
        print("contact button pressed")
        let contactGymAlert: UIAlertController = UIAlertController(title: "Contact Us", message: nil, preferredStyle: .actionSheet)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) {
            action -> Void in
        }
        let emailAction: UIAlertAction = UIAlertAction(title: "Email", style: .default, handler: { action in
            print("email")
            self.sendEmail()
        })
        let textAction: UIAlertAction = UIAlertAction(title: "Text", style: .default, handler: { action in
            print("text")
            self.sendText()
        })
        let callAction: UIAlertAction = UIAlertAction(title: "Call", style: .default, handler: { action in
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
