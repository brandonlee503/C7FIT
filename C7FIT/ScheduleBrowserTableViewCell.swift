//
//  ScheduleBrowserTableViewCell.swift
//  C7FIT
//
//  Created by Michael Lee on 1/25/17.
//  Copyright © 2017 Brandon Lee. All rights reserved.
//

import UIKit

class ScheduleBrowserTableViewCell: UITableViewCell {

    
    lazy var scheduleTitle: UILabel = UILabel()
    lazy var schedulePicture: UIImageView = UIImageView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("browser cell")
        setup()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setup(){
        scheduleTitle.backgroundColor = .white
        scheduleTitle.text = "Monthly Schedule"
        addSubview(scheduleTitle)
        
        let imageName = "temp.png"
        let image = UIImage(named: imageName)
        if (image != nil){
            schedulePicture.image = image!
            addSubview(schedulePicture)
            print("image success")
        }
        else{
            print("image error")
        }
    }

    func setupConstraints() {
        scheduleTitle.translatesAutoresizingMaskIntoConstraints = false
        let titleLead = scheduleTitle.leftAnchor.constraint(equalTo: leftAnchor, constant:10)
        let titleTrail = scheduleTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-10)
        let titleTop = scheduleTitle.topAnchor.constraint(equalTo: topAnchor, constant: 20)
        let titleBot = scheduleTitle.bottomAnchor.constraint(equalTo: schedulePicture.topAnchor, constant: -10)
        NSLayoutConstraint.activate([titleLead,titleTrail,titleTop,titleBot])
        
        schedulePicture.translatesAutoresizingMaskIntoConstraints = false
        let imageLeft = schedulePicture.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
        let imageTop = schedulePicture.topAnchor.constraint(equalTo: scheduleTitle.bottomAnchor, constant:10)
        let imageBottom = schedulePicture.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        NSLayoutConstraint.activate([imageLeft, imageTop, imageBottom ])
    }
    
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
