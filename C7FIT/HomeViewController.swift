import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties

    let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0),
                                          collectionViewLayout: UICollectionViewFlowLayout())

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .orange

        self.view.addSubview(collectionView)
        setupConstraints()
        self.view.setNeedsUpdateConstraints()

        collectionView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)

        collectionView.dataSource = self
        collectionView.register(YouTubeCollectionViewCell.classForCoder(),
                                forCellWithReuseIdentifier: "YouTubeCollectionViewCell")
        collectionView.register(UICollectionViewCell.classForCoder(),
                                forCellWithReuseIdentifier: "OtherCollectionViewCell")

        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: view.frame.width,
                                               height: (view.frame.height - 180) / 3)
        collectionViewLayout.minimumLineSpacing = 20

        collectionView.setCollectionViewLayout(collectionViewLayout, animated: false)
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YouTubeCollectionViewCell",
                                                          for: indexPath)
            if let cell = cell as? YouTubeCollectionViewCell {
                cell.videoID = "LR708uA4zQ8"
            }
            return cell

        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtherCollectionViewCell",
                                                          for: indexPath)
            cell.contentView.backgroundColor = .red
            return cell
        }
    }

}
