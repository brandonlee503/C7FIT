import UIKit

class MotivationalQuoteCollectionViewCell: UICollectionViewCell {

    let quoteLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        quoteLabel.text = "Life is like a box of chocolates"
        quoteLabel.textColor = .gray
        quoteLabel.textAlignment = .left
        quoteLabel.font = UIFont.systemFont(ofSize: 32)
        quoteLabel.frame = contentView.bounds


        contentView.addSubview(quoteLabel)
        contentView.clipsToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
