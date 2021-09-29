//
//  PersonInfoViewController.swift
//  PersonInfoAppTest
//
//  Created by Admin on 29.09.21.
//

import UIKit

class PersonInfoViewController: UIViewController {

    @IBOutlet
    private weak var identifierLabel: UILabel!

    @IBOutlet
    private weak var firstNameLabel: UILabel!

    @IBOutlet
    private weak var lastNameLabel: UILabel!

    @IBOutlet
    private weak var genderLabel: UILabel!

    @IBOutlet
    private weak var ageLabel: UILabel!

    @IBOutlet
    private weak var personIconImageView: UIImageView!

    private var viewModel: PersonInfoViewModel?

    private var person: PersonInfoData? {
        didSet {
            guard let person = person else {
                return
            }
            identifierLabel.text = String(person.identifier)
            firstNameLabel.text = person.firstName
            lastNameLabel.text = person.lastName
            genderLabel.text = person.gender
            ageLabel.text = String(person.age)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PersonInfoViewModelImplemetation(self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.loadData { [weak self] person in
            self?.person = person
        }
    }
}
