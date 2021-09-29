//
//  CollectionViewModelImplementation.swift
//  PersonInfoAppTest
//
//  Created by Admin on 29.09.21.
//

import Foundation

class CollectionViewModelImplementation: CollectionViewModel {

    weak var viewController: CollectionViewController?

    init (_ viewController: CollectionViewController) {
        self.viewController = viewController
    }

    func loadRequest(_ completion: @escaping ([CollectionPersonData]) -> Void) {
        HTTPClient.shared.fetchAvailablePersonData { results in
            switch results {
            case .success( let data):
                completion(data)
            case .failure( let error):
                print(error.localizedDescription)
            }
        }
    }
}
