//
//  PersonInfoViewModel.swift
//  PersonInfoAppTest
//
//  Created by Admin on 29.09.21.
//

import Foundation

protocol PersonInfoViewModel {

    func loadData(_ completion: @escaping (PersonInfoData) -> Void)
}
