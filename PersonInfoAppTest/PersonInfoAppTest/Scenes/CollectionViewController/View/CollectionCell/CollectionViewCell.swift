//
//  CollectionViewCell.swift
//  PersonInfoAppTest
//
//  Created by Admin on 29.09.21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: CollectionViewCell.self)

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
}
