import UIKit

enum CollectionViewCellType: String {
    case youtube
    case trainers
    case motivational
}

class HomeViewController: UIViewController {

    // MARK: - Properties

    let collectionView = UICollectionView(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: 0,
                                                        height: 0),
                                          collectionViewLayout: UICollectionViewFlowLayout())

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Appearance
        title = "Home"

        // Add collectionView
        view.addSubview(collectionView)
        setupConstraints()
        view.setNeedsUpdateConstraints()
        collectionView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        collectionView.backgroundColor = UIColor(white: 0.9, alpha: 1.0)

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(YouTubeCollectionViewCell.classForCoder(),
                                forCellWithReuseIdentifier: CollectionViewCellType.youtube.rawValue)
        collectionView.register(TrainersCollectionViewCell.classForCoder(),
                                forCellWithReuseIdentifier: CollectionViewCellType.trainers.rawValue)
        collectionView.register(MotivationalQuoteCollectionViewCell.classForCoder(),
                                forCellWithReuseIdentifier: CollectionViewCellType.motivational.rawValue)

        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: view.frame.width,
                                               height: (view.frame.height - 140) / 3)
        collectionViewLayout.minimumLineSpacing = 8
        collectionView.setCollectionViewLayout(collectionViewLayout,
                                               animated: false)
    }

    // MARK: - Layout

    func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let topView = collectionView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomView = collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leftView = collectionView.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightView = collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        NSLayoutConstraint.activate([topView, bottomView, leftView, rightView])
    }
}

extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellType.youtube.rawValue,
                                                          for: indexPath)
            if let cell = cell as? YouTubeCollectionViewCell {
                cell.videoID = "SGGKHqYEMqc"
            }
            return cell

        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellType.trainers.rawValue,
                                                          for: indexPath)
            return cell

        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellType.motivational.rawValue,
                                                          for: indexPath)
            if let cell = cell as? MotivationalQuoteCollectionViewCell,
                let url = Bundle.main.url(forResource: "youCanDoIt", withExtension: "mp3") {
                cell.audioUrl = url
            }
            return cell

        default:
            fatalError("This should not be happening. SAD!")
        }
    }

}

extension HomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            let trainersViewController = TrainersViewController()
            navigationController?.pushViewController(trainersViewController,
                                                     animated: true)
        case 2:
            let cell = collectionView.cellForItem(at: indexPath) as! MotivationalQuoteCollectionViewCell
            cell.togglePlayback()
        default:
            return
        }
    }

}
