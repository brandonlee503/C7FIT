import UIKit

class TrainerCell: UICollectionViewCell {

    let trainersLabel = UILabel()
    let coverPhotoImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        trainersLabel.text = "View trainers"
        trainersLabel.textColor = .white
        trainersLabel.textAlignment = .center
        trainersLabel.font = UIFont.systemFont(ofSize: 22)
        trainersLabel.frame = contentView.bounds

        coverPhotoImageView.image = #imageLiteral(resourceName: "trainer")
        coverPhotoImageView.contentMode = .scaleAspectFill
        coverPhotoImageView.frame = contentView.bounds

        let gradient = CAGradientLayer()
        gradient.frame = coverPhotoImageView.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.0, 1.0]
        coverPhotoImageView.layer.addSublayer(gradient)

        contentView.insertSubview(trainersLabel, at: 1)
        contentView.insertSubview(coverPhotoImageView, at: 0)
        contentView.clipsToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
