//
//  TableViewCell.swift
//  PersonInfoAppTest
//
//  Created by Admin on 29.09.21.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let identifier = String(describing: TableViewCell.self)

    @IBOutlet weak var genderLabel: UILabel!

    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var ageLabel: UILabel!

}
