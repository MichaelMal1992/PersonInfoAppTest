//
//  OnlyWomansButton.swift
//  PersonInfoAppTest
//
//  Created by Admin on 29.09.21.
//

import UIKit

class OnlyWomansButton: UIButton {

    private let title = "F"

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        setTitle(title, for: .normal)
        setTitleColor(.systemBlue, for: .normal)
    }

    func selected(selected: @escaping () -> Void, notSelected: @escaping () -> Void) {
        switch isSelected {
        case true:
            selected()
        case false:
            notSelected()
        }
    }
}
