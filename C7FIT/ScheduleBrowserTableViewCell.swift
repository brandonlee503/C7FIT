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
    lazy var scheduleLink: UIButton = UIButton()

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
        
        let imageName = "temp.png"
        let bgImage = UIImage(named: imageName)

        
        if (bgImage != nil){
            schedulePicture.image = bgImage!
            schedulePicture.center = self.center

            addSubview(schedulePicture)
            print("image success")
        }
        else{
            print("image error")
        }
        
        scheduleLink.setImage(bgImage, for: .normal)
        addSubview(scheduleLink)
        
        scheduleTitle.text = "Monthly Schedule"
        scheduleTitle.textAlignment = NSTextAlignment.center
        addSubview(scheduleTitle)
//        if (bgImage != nil){
//            schedulePicture.image = bgImage!
//            print("image success")
//        }
//        else{
//            print("image error")
//        }
//        self.backgroundView = schedulePicture
      
    }

    func setupConstraints() {
        scheduleTitle.translatesAutoresizingMaskIntoConstraints = false
        let titleLead = scheduleTitle.leftAnchor.constraint(equalTo: leftAnchor, constant:10)
        let titleTrail = scheduleTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-10)
        let titleTop = scheduleTitle.topAnchor.constraint(equalTo: topAnchor, constant: 20)
        NSLayoutConstraint.activate([titleLead,titleTrail,titleTop])
        
////        let cellWidth: CGFloat? = self.contentView.frame.size.width
//        schedulePicture.translatesAutoresizingMaskIntoConstraints = false
////        let imageLeft = schedulePicture.leftAnchor.constraint(equalTo: leftAnchor, constant: 0)
//        let imageTop = schedulePicture.topAnchor.constraint(equalTo: topAnchor, constant:0)
//        let imageBottom = schedulePicture.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
//        NSLayoutConstraint.activate([imageTop, imageBottom ])
        
        scheduleLink.translatesAutoresizingMaskIntoConstraints = false
        let linkLead = scheduleLink.leftAnchor.constraint(equalTo: leftAnchor, constant:0)
        let linkTrail = scheduleLink.trailingAnchor.constraint(equalTo: trailingAnchor, constant:0)
        let linkTop = scheduleLink.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        let linkBot = scheduleLink.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        NSLayoutConstraint.activate([linkLead,linkTrail,linkTop,linkBot])
    
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
