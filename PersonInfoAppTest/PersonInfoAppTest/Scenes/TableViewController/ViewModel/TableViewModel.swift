//
//  TableViewModel.swift
//  PersonInfoAppTest
//
//  Created by Admin on 29.09.21.
//

import Foundation

protocol TableViewModel {

    func loadRequest(_ completion: @escaping ([TablePersonData]) -> Void)
}
