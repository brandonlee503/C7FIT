import UIKit

enum CollectionViewCellType: String {
    case youtube
    case trainers
    case motivational
}

class HomeViewController: UIViewController {

    // MARK: - Constants

    let firebaseDataManager = FirebaseDataManager()
    let collectionView = UICollectionView(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: 0,
                                                        height: 0),
                                          collectionViewLayout: UICollectionViewFlowLayout())

    // MARK: - Properties

    var videoID: String?
    var quote: String?
    var trainers: [Trainer] = []

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

        collectionView.register(YouTubeCell.classForCoder(),
                                forCellWithReuseIdentifier: CollectionViewCellType.youtube.rawValue)
        collectionView.register(TrainerCell.classForCoder(),
                                forCellWithReuseIdentifier: CollectionViewCellType.trainers.rawValue)
        collectionView.register(QuoteCell.classForCoder(),
                                forCellWithReuseIdentifier: CollectionViewCellType.motivational.rawValue)

        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: view.frame.width,
                                               height: (view.frame.height - 140) / 3)
        collectionViewLayout.minimumLineSpacing = 8
        collectionView.setCollectionViewLayout(collectionViewLayout,
                                               animated: false)

        // Fetch all assets from firebase and set them accordingly
        fetchAssets()
    }

    func fetchAssets() {
        firebaseDataManager.fetchHomeScreenInfo { data in
            guard let json = data.value as? [String: Any] else { return }
            guard let videos = json["videos"] as? [String: Any] else { return }
            guard let quotes = json["quotes"] as? [String: Any] else { return }
            guard let trainerJSON = json["trainers"] as? [String: Any] else { return }

            // Load random video and quote
            let videoIndex = Int(arc4random_uniform(UInt32(videos.count)))
            let quoteIndex = Int(arc4random_uniform(UInt32(quotes.count)))
            self.videoID = Array(videos.values)[videoIndex] as? String
            self.quote = Array(quotes.values)[quoteIndex] as? String

            // Load trainers for detail view
            for trainer in trainerJSON {
                let fullName = trainer.key.components(separatedBy: " ")
                let trainerDetails = trainer.value as? [String: Any]
                let avatar = trainerDetails?["avatar"] as! String
                let avatarURL = URL(string: avatar)!
                let bio = trainerDetails?["bio"] as! String
                self.trainers.append(Trainer(firstName: fullName.first!,
                                              lastName: fullName.last!,
                                              bio: bio,
                                              avatar: avatarURL,
                                              coverPhoto: nil))
            }
            self.collectionView.reloadData()
        }
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
            if let cell = cell as? YouTubeCell {
                cell.videoID = videoID
            }
            return cell

        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellType.trainers.rawValue,
                                                          for: indexPath)
            return cell

        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellType.motivational.rawValue,
                                                          for: indexPath)
            if let cell = cell as? QuoteCell,
                let url = Bundle.main.url(forResource: "youCanDoIt", withExtension: "mp3") {
                cell.audioUrl = url
                cell.quoteLabel.text = quote
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
            let trainersViewController = TrainersViewController(trainerData: trainers)
            navigationController?.pushViewController(trainersViewController,
                                                     animated: true)
        case 2:
            let cell = collectionView.cellForItem(at: indexPath) as! QuoteCell
            cell.togglePlayback()
        default:
            return
        }
    }
}
