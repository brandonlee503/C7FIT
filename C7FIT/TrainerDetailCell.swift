import UIKit

class TrainerDetailCell: UICollectionViewCell {

    var name: String?
    var title: String?
    var avatar: UIImage?
    var coverPhoto: UIImage?

    let nameLabel = UILabel()
    let titleLabel = UILabel()
    let avatarImageView = UIImageView()
    let coverPhotoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        nameLabel.text = "Rutger Farry"
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 22)

        titleLabel.text = "Freelance Mecha Designer"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 18)

        contentView.insertSubview(nameLabel, at: 1)
        contentView.insertSubview(titleLabel, at: 1)
        contentView.insertSubview(avatarImageView, at: 1)
        contentView.insertSubview(coverPhotoImageView, at: 0)

        avatarImageView.image = #imageLiteral(resourceName: "spongebob")

        coverPhotoImageView.image = #imageLiteral(resourceName: "trainer")
        coverPhotoImageView.contentMode = .scaleAspectFill

        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {
        let margins = contentView.layoutMarginsGuide
        let avatarImageViewSize: CGFloat = 50
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false

        nameLabel.bottomAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8.0).isActive = true

        titleLabel.topAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8.0).isActive = true

        avatarImageView.widthAnchor.constraint(equalToConstant: avatarImageViewSize).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: avatarImageViewSize).isActive = true
        avatarImageView.centerYAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true

        // Make circular avatarImageView
        avatarImageView.layer.cornerRadius = avatarImageViewSize / 2
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.masksToBounds = true
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    override func layoutSubviews() {
        coverPhotoImageView.frame = contentView.bounds

        let gradient = CAGradientLayer()
        gradient.frame = coverPhotoImageView.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.0, 1.0]
        coverPhotoImageView.layer.addSublayer(gradient)
        contentView.clipsToBounds = true
    }

}
