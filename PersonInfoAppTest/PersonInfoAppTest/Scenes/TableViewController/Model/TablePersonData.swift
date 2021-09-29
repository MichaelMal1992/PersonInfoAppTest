//
//  TablePersonData.swift
//  PersonInfoAppTest
//
//  Created by Admin on 29.09.21.
//

import Foundation

struct TablePersonData: Codable {

    let identifier: Int
    let firstName: String
    let lastName: String
    let gender: String
    let avatar: String
    let age: Int

    enum CodingKeys: String, CodingKey {
        
        case identifier = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case gender
        case avatar
        case age
    }
}
