import UIKit

class TrainersCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)

        let trainersLabel = UILabel(frame: contentView.bounds)
        trainersLabel.text = "View trainers >"

        contentView.addSubview(trainersLabel)
        contentView.clipsToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
