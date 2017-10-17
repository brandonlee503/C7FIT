import UIKit

let trainerCellIdentifier = "TrainerDetailCell"

class TrainersViewController: UIViewController {

    // MARK: - Constants

    let collectionView = UICollectionView(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: 0,
                                                        height: 0),
                                          collectionViewLayout: UICollectionViewFlowLayout())

    // MARK: - Properties

    lazy var trainers: [Trainer] = []

    // MARK: - Initialization

    init(trainerData: [Trainer]) {
        super.init(nibName: nil, bundle: nil)
        trainers = trainerData
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Appearance
        title = "Trainers"
        collectionView.backgroundColor = UIColor(white: 0.9, alpha: 1.0)

        // Add collectionView
        view.addSubview(collectionView)
        setupConstraints()
        view.setNeedsUpdateConstraints()
        collectionView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)

        collectionView.dataSource = self

        collectionView.register(TrainerDetailCell.classForCoder(),
                                forCellWithReuseIdentifier: trainerCellIdentifier)

        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: view.frame.width,
                                               height: (view.frame.height - 180) / 3)
        collectionView.setCollectionViewLayout(collectionViewLayout,
                                               animated: false)
    }

    // MARK: - Layout

    func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

extension TrainersViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trainers.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: trainerCellIdentifier,
                                                         for: indexPath) as? TrainerDetailCell {
            cell.backgroundColor = .white
            cell.nameLabel.text = "\(trainers[indexPath.item].firstName) \(trainers[indexPath.item].lastName)"
            cell.bioLabel.text = trainers[indexPath.item].bio
            cell.avatarImageView.downloadImageFromFirebase(url: trainers[indexPath.item].avatar, imageMode: .scaleAspectFit)
            return cell
        }
        return UICollectionViewCell()
    }
}
