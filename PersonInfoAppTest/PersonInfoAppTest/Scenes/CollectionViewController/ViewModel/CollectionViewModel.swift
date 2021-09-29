//
//  CollectionViewModel.swift
//  PersonInfoAppTest
//
//  Created by Admin on 29.09.21.
//

import Foundation

protocol CollectionViewModel {

    func loadRequest(_ completion: @escaping ([CollectionPersonData]) -> Void)
}
