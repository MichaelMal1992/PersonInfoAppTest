//
//  SortedAgeButton.swift
//  PersonInfoAppTest
//
//  Created by Admin on 29.09.21.
//

import UIKit

class SortedAgeButton: UIButton {

    private let image = UIImage(systemName: "arrow.up.arrow.down")

    private let arrrowDownImage = UIImage(systemName: "arrow.down")

    private let arrrowUpImage = UIImage(systemName: "arrow.up")

    private let title = "age"

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        setTitle(title, for: .normal)
        setImage(image, for: .normal)
        setTitleColor(.systemBlue, for: .normal)
    }

    func selected(selected: @escaping () -> Void, notSelected: @escaping () -> Void) {
        switch isSelected {
        case true:
            setImage(arrrowDownImage, for: .normal)
            selected()
        case false:
            setImage(arrrowUpImage, for: .normal)
            notSelected()
        }
    }
}

