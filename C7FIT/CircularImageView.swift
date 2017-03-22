//
//  CircularImageView.swift
//  C7FIT
//
//  Created by Brandon Lee on 1/24/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

/**
    UIImageView adapter subclass to create rounded images as autolayout and CGLayer don't mix very well...
    http://stackoverflow.com/questions/32362934/how-to-keep-a-round-imageview-round-using-auto-layout
 */
class CircularImageView: C7FUIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius: CGFloat = self.bounds.size.width / 2
        self.layer.cornerRadius = radius
    }
}
