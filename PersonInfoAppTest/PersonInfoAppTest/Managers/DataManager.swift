//
//  DataManager.swift
//  PersonInfoAppTest
//
//  Created by Admin on 29.09.21.
//

import Foundation

class DataManager {

    static let shared = DataManager()

    let key = "UserDefaults_PersonData_key"

    private let userDefaults = UserDefaults.standard

    func save(_ person: TablePersonData) {
        do {
            let data = try JSONEncoder().encode(person)
            userDefaults.setValue(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func get() -> TablePersonData? {
        if let data = userDefaults.value(forKey: key) as? Data {
            do {
                let person = try JSONDecoder().decode(TablePersonData.self, from: data)
                return person
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
