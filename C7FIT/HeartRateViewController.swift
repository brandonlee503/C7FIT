//
//  HeartRateViewController.swift
//  C7FIT
//
//  Created by Michael Lee on 2/15/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class HeartRateViewController: UIViewController {

    // MARK: - Properties

    var heartRateView = HeartRateView()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Heart Rate"
        self.view.backgroundColor = .white

        self.view.addSubview(heartRateView)
        setupConstraints()
        self.view.setNeedsUpdateConstraints()
    }

    // MARK: - Layout

    func setupConstraints() {
        heartRateView.translatesAutoresizingMaskIntoConstraints = false
        let topView = heartRateView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomView = heartRateView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leftView = heartRateView.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightView = heartRateView.rightAnchor.constraint(equalTo: view.rightAnchor)
        NSLayoutConstraint.activate([topView, bottomView, leftView, rightView])
    }

}
