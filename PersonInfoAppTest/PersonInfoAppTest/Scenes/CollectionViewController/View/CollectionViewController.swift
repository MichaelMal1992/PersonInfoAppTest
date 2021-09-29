//
//  CollectionViewController.swift
//  PersonInfoAppTest
//
//  Created by Admin on 29.09.21.
//

import UIKit

class CollectionViewController: UIViewController {

    @IBOutlet
    private weak var personInfoCollectionView: UICollectionView!

    @IBOutlet
    private weak var showOnlyMansButton: UIButton!

    @IBOutlet
    private weak var showOnlyWomansButton: UIButton!

    @IBOutlet
    private weak var showSortedAgeButton: UIButton!
    
    @IBOutlet
    private weak var activityIndicator: UIActivityIndicatorView!

    private let arrrowDownImage = UIImage(systemName: "arrow.down")

    private let arrrowUpImage = UIImage(systemName: "arrow.up")

    private var refresh: UIRefreshControl?

    private var viewModel: CollectionViewModel?

    private var personData = [CollectionPersonData]() {
        didSet {
            if showSortedAgeButton.currentImage == arrrowDownImage {
                personData.sort { $0.age > $1.age }
            } else if showSortedAgeButton.currentImage == arrrowUpImage {
                personData.sort { $0.age < $1.age }
            }
            personInfoCollectionView.isHidden = false
            refresh?.endRefreshing()
            activityIndicator.stopAnimating()
            personInfoCollectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CollectionViewModelImplementation(self)
        setupRefreshControl()
        setupCollectionView()
        loadReaquest()
    }

    @IBAction
    private func showOnlyMansButtonPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            setupSelected("M", enabledFalse: showOnlyWomansButton)
        } else {
            setupNotSelected(enabledTrue: showOnlyWomansButton)
        }
    }

    @IBAction
    private func showOnlyWomansButtonPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            setupSelected("F", enabledFalse: showOnlyMansButton)
        } else {
            setupNotSelected(enabledTrue: showOnlyMansButton)
        }
    }

    @IBAction
    private func showSortedAgeButtonPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.setImage(arrrowDownImage, for: .normal)
            personData.sort { $0.age > $1.age }
        } else {
            sender.setImage(arrrowUpImage, for: .normal)
            personData.sort { $0.age < $1.age }
        }
    }

    private func loadReaquest() {
        viewModel?.loadRequest { [weak self] data in
            self?.personData = data
        }
    }

    private func setupSelected(_ filter: String, enabledFalse: UIButton) {
        enabledFalse.isEnabled = false
        personData = personData.filter { $0.gender == filter }
    }

    private func setupNotSelected(enabledTrue: UIButton) {
        enabledTrue.isEnabled = true
        personInfoCollectionView.isHidden = true
        activityIndicator.startAnimating()
        loadReaquest()
    }

    private func setupCollectionView() {
        personInfoCollectionView.isHidden = true
        personInfoCollectionView.dataSource = self
        personInfoCollectionView.delegate = self
        personInfoCollectionView.refreshControl = refresh
        let nib = UINib(nibName: CollectionViewCell.identifier, bundle: nil)
        personInfoCollectionView.register(nib, forCellWithReuseIdentifier: CollectionViewCell.identifier)
    }

    private func setupRefreshControl() {
        refresh = UIRefreshControl()
        refresh?.attributedTitle = NSAttributedString(string: "Updating...")
        refresh?.addTarget(self, action: #selector(handlerRefresh(_:)), for: .valueChanged)
    }

    @objc
    private func handlerRefresh(_ sender: UIRefreshControl) {
        personData = []
        loadReaquest()
    }
}

extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        personData.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        let person = personData[indexPath.row]
        cell.genderLabel.text = person.gender
        cell.nameLabel.text = person.firstName
        cell.ageLabel.text = String(person.age)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = personData[indexPath.item]
        let person = TablePersonData(identifier: data.identifier,
                                firstName: data.firstName,
                                lastName: data.lastName,
                                gender: data.gender,
                                avatar: data.avatar,
                                age: data.age)

        DataManager.shared.save(person)
        let viewController = ViewControllerFactory.shared.create(String(describing: PersonInfoViewController.self))
        navigationController?.pushViewController(viewController, animated: true)
    }
}

