//
//  ScheduleView.swift
//  C7FIT
//
//  Created by Brandon Lee on 12/22/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit

class ScheduleView: UIView {
    
    // MARK: - Properties
    
    var titleLabel: UILabel = UILabel()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        setupConstraints()
    }
    
    // MARK: - Layout
    
    func setup() {

    }
    
    func setupConstraints() {

    }
}
