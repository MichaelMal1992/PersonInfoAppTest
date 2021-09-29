//
//  TableViewModelImplementation.swift
//  PersonInfoAppTest
//
//  Created by Admin on 29.09.21.
//

import Foundation

class TableViewModelImplementation: TableViewModel {

    weak var viewController: TableViewController?

    init(_ viewController: TableViewController) {
        self.viewController = viewController
    }

    func loadRequest(_ completion: @escaping ([TablePersonData]) -> Void) {
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
