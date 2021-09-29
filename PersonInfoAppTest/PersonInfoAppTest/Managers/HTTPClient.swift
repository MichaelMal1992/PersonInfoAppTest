//
//  HTTPClient.swift
//  PersonInfoAppTest
//
//  Created by Admin on 29.09.21.
//

import Foundation
import UIKit

class HTTPClient {

    static let shared = HTTPClient()

    private let endPoints = "https://my.api.mockaroo.com/users.json?key=f0ce7b20"
    
    func fetchAvailablePersonData(queue: DispatchQueue = .main,
                                   _ completion: @escaping (Result<[TablePersonData], Error>) -> Void) {
        guard let url = URL(string: endPoints) else {
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                queue.async {
                    completion(.failure(error))
                }
                return
            }
            guard let data = data else {
                print("no data in response")
                return
            }
            do {
                let personDatas = try JSONDecoder().decode([TablePersonData].self, from: data)
                queue.async {
                    completion(.success(personDatas))
                }
            } catch {
                queue.async {
                    completion(.failure(error))
                }
                return
            }
        }
        task.resume()
    }

    func downloadImage(_ avatar: String, queue: DispatchQueue = .main,
                       _ completion: @escaping (Result<UIImage?, Error>) -> Void) {
        let string = avatar.replacingOccurrences(of: "u0026set=set1", with: "")
        guard let url = URL(string: string) else {
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                queue.async {
                    completion(.failure(error))
                }
            }
            if let data = data {
                let image = UIImage(data: data)
                queue.async {
                    completion(.success(image))
                }
            }
        }
        task.resume()
    }
}
