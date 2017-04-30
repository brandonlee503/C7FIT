import UIKit

class MotivationalQuoteCollectionViewCell: UICollectionViewCell {

    let quoteLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        quoteLabel.text = "Life is like a box of chocolates"
        quoteLabel.textColor = .gray
        quoteLabel.textAlignment = .left
        quoteLabel.font = UIFont.systemFont(ofSize: 32)
        quoteLabel.lineBreakMode = .byWordWrapping
        quoteLabel.numberOfLines = 0

        contentView.addSubview(quoteLabel)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        quoteLabel.frame = contentView.layoutMarginsGuide.layoutFrame
    }

}
