import UIKit

let trainerCellIdentifier = "TrainerCollectionViewCell"

class TrainersViewController: UIViewController {

    // MARK: - Properties

    let collectionView = UICollectionView(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: 0,
                                                        height: 0),
                                          collectionViewLayout: UICollectionViewFlowLayout())

    let trainers: [Trainer] = [Trainer(firstName: "Rutger",
                                       lastName: "Farry",
                                       bio: "Freelance mecha designer",
                                       avatar: #imageLiteral(resourceName: "tab_person_6x"),
                                       coverPhoto: #imageLiteral(resourceName: "club front"))]

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Appearance
        title = "Trainers"
        navigationController?.navigationBar.barTintColor = .orange

        // Add collectionView
        view.addSubview(collectionView)
        setupConstraints()
        view.setNeedsUpdateConstraints()
        collectionView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)

        collectionView.dataSource = self

        collectionView.register(TrainerCollectionViewCell.classForCoder(),
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
        let topView = collectionView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomView = collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leftView = collectionView.leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightView = collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        NSLayoutConstraint.activate([topView, bottomView, leftView, rightView])
    }

}

extension TrainersViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trainers.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: trainerCellIdentifier,
                                                      for: indexPath)
        cell.backgroundColor = .white
        return cell
    }

}
