//
//  ViewController.swift
//  PersonInfoAppTest
//
//  Created by Admin on 29.09.21.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet
    private weak var personInfoTableView: UITableView!

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

    private var viewModel: TableViewModel?

    private var personData = [TablePersonData]() {
        didSet {
            if showSortedAgeButton.currentImage == arrrowDownImage {
                personData.sort { $0.age > $1.age }
            } else if showSortedAgeButton.currentImage == arrrowUpImage {
                personData.sort { $0.age < $1.age }
            }
            personInfoTableView.isHidden = false
            refresh?.endRefreshing()
            activityIndicator.stopAnimating()
            personInfoTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TableViewModelImplementation(self)
        setupRefreshControl()
        setupTableView()
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
        personInfoTableView.isHidden = true
        activityIndicator.startAnimating()
        loadReaquest()
    }

    private func setupTableView() {
        personInfoTableView.isHidden = true
        personInfoTableView.dataSource = self
        personInfoTableView.delegate = self
        personInfoTableView.refreshControl = refresh
        let nib = UINib(nibName: String(describing: TableViewCell.self), bundle: nil)
        personInfoTableView.register(nib, forCellReuseIdentifier: TableViewCell.identifier)
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

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        personData.count
        
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as? TableViewCell else {
            return UITableViewCell()
        }

        let person = personData[indexPath.row]
        cell.genderLabel.text = person.gender
        cell.nameLabel.text = person.firstName
        cell.ageLabel.text = String(person.age)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = personData[indexPath.row]
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


