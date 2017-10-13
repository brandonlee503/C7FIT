import UIKit

class TrainerDetailCell: UICollectionViewCell {

    let nameLabel = UILabel()
    let bioLabel = UILabel()
    let avatarImageView = CircularImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        nameLabel.font = .systemFont(ofSize: 22)
        
        bioLabel.adjustsFontSizeToFitWidth = true
        bioLabel.minimumScaleFactor = 0.5
        bioLabel.numberOfLines = 0
        bioLabel.lineBreakMode = .byTruncatingTail
        bioLabel.textAlignment = .left

        contentView.insertSubview(nameLabel, at: 1)
        contentView.insertSubview(bioLabel, at: 1)
        contentView.insertSubview(avatarImageView, at: 1)

        avatarImageView.image = #imageLiteral(resourceName: "profile_placeholder")
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.masksToBounds = false
        avatarImageView.layer.borderColor = UIColor.black.cgColor
        avatarImageView.clipsToBounds = true
        avatarImageView.contentMode = .scaleAspectFill

        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {
        let margins = contentView.layoutMarginsGuide
        let avatarImageViewSize: CGFloat = 100
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        bioLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            avatarImageView.leftAnchor.constraint(equalTo: margins.leftAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: avatarImageViewSize),
            avatarImageView.heightAnchor.constraint(equalToConstant: avatarImageViewSize)
        ])

        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor)
        ])

        NSLayoutConstraint.activate([
            bioLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 1),
            bioLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            bioLabel.rightAnchor.constraint(equalTo: margins.rightAnchor),
            bioLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -5)
        ])
    }
}
