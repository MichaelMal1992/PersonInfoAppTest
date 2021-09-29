//
//  PersonInfoViewModelImplemetation.swift
//  PersonInfoAppTest
//
//  Created by Admin on 29.09.21.
//

import Foundation
import UIKit

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

    func loadImage(avatar: String, _ completion: @escaping (UIImage?) -> Void) {
        HTTPClient.shared.downloadImage(avatar) { results in
            switch results {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
