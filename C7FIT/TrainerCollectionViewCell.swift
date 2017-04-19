import UIKit

class TrainerCollectionViewCell: UICollectionViewCell {

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
        titleLabel.text = "Freelance Mecha Designer"

        contentView.insertSubview(nameLabel, at: 1)
        contentView.insertSubview(titleLabel, at: 1)
        contentView.insertSubview(avatarImageView, at: 1)
        contentView.insertSubview(coverPhotoImageView, at: 0)
        contentView.clipsToBounds = true

        avatarImageView.image = #imageLiteral(resourceName: "spongebob")
        coverPhotoImageView.image = #imageLiteral(resourceName: "mountain")

        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {
        let margins = contentView.layoutMarginsGuide
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false

        nameLabel.bottomAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor).isActive = true

        titleLabel.topAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor).isActive = true

        avatarImageView.widthAnchor.constraint(equalToConstant: 50)
        avatarImageView.heightAnchor.constraint(equalToConstant: 50)
        avatarImageView.centerYAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true

        // Make circular avatarImageView
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.masksToBounds = true
        avatarImageView.contentMode = .scaleAspectFill

        coverPhotoImageView.frame = contentView.bounds
    }

}
