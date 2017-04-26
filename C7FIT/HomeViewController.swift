import UIKit

enum CollectionViewCellType: String {
    case youtube
    case trainers
    case other
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
        navigationController?.navigationBar.barTintColor = .orange

        // Add collectionView
        view.addSubview(collectionView)
        setupConstraints()
        view.setNeedsUpdateConstraints()
        collectionView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(YouTubeCollectionViewCell.classForCoder(),
                                forCellWithReuseIdentifier: CollectionViewCellType.youtube.rawValue)
        collectionView.register(TrainersCollectionViewCell.classForCoder(),
                                forCellWithReuseIdentifier: CollectionViewCellType.trainers.rawValue)
        collectionView.register(UICollectionViewCell.classForCoder(),
                                forCellWithReuseIdentifier: CollectionViewCellType.other.rawValue)

        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: view.frame.width,
                                               height: (view.frame.height - 180) / 3)
        collectionViewLayout.minimumLineSpacing = 20
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
                cell.videoID = "LR708uA4zQ8"
            }
            return cell

        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellType.trainers.rawValue,
                                                          for: indexPath)
            cell.contentView.backgroundColor = .green
            return cell

        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellType.other.rawValue,
                                                          for: indexPath)
            cell.contentView.backgroundColor = .red
            return cell
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
        default:
            return
        }
    }

}
