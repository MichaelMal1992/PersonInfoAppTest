//
//  PersonInfoViewModel.swift
//  PersonInfoAppTest
//
//  Created by Admin on 29.09.21.
//

import Foundation
import UIKit

protocol PersonInfoViewModel {

    func loadData(_ completion: @escaping (PersonInfoData) -> Void)

    func loadImage(avatar: String, _ completion: @escaping (UIImage?) -> Void)
}
