//
//  PersonInfoViewModelImplemetation.swift
//  PersonInfoAppTest
//
//  Created by Admin on 29.09.21.
//

import Foundation

class PersonInfoViewModelImplemetation: PersonInfoViewModel {

    weak var viewController: PersonInfoViewController?

    init(_ viewController: PersonInfoViewController) {
        self.viewController = viewController
    }

    func loadData(_ completion: @escaping (PersonInfoData) -> Void) {
        if let person = DataManager.shared.get() {
            completion(person)
        }
    }
}
