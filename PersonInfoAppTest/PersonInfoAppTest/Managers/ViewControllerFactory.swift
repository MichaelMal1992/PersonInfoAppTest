//
//  ViewControllerFactory.swift
//  PersonInfoAppTest
//
//  Created by Admin on 29.09.21.
//

import UIKit

class ViewControllerFactory {

    static let shared = ViewControllerFactory()

    func create(_ viewController: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: viewController)
        return viewController
    }
}
