import UIKit

class TrainerCollectionViewCell: UICollectionViewCell {

    var name: String?
    var title: String?
    var avatar: UIImage?
    var coverPhoto: UIImage?

    fileprivate let _nameLabel = UILabel()
    fileprivate let _titleLabel = UILabel()
    fileprivate let _avatarImageView = UIImageView()
    fileprivate let _coverPhotoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        _nameLabel.text = "Rutger Farry"
        _titleLabel.text = "Freelance Mecha Designer"

        contentView.addSubview(_nameLabel)
        contentView.addSubview(_titleLabel)
        contentView.addSubview(_avatarImageView)
        contentView.addSubview(_coverPhotoImageView)
        contentView.clipsToBounds = true

        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {
        let margins = contentView.layoutMarginsGuide
        _nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            _nameLabel.topAnchor.constraint(equalTo: margins.topAnchor),
            _nameLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            _titleLabel.topAnchor.constraint(equalTo: _nameLabel.bottomAnchor),
            _titleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        ])
    }

}
