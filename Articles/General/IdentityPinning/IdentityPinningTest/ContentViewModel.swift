//
//  ContentViewModel.swift
//  IdentityPinningTest
//
//  Created by Jolanta Zakrzewska on 10/08/2022.
//

import SwiftUI
import Alamofire

final class ContentViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var json: String?

    let imageApi = "https://cataas.com/cat"
    let jsonApi = "https://jsonplaceholder.typicode.com/todos/1"

    func loadImageWithURLSession(completion: @escaping (Bool, Error?) -> Void) {
        guard let imageUrl = URL(string: imageApi) else { return }

        let urlSession = URLSession(configuration: URLSessionConfiguration.ephemeral)

        let task = urlSession.dataTask(with: imageUrl) { [weak self] imageData, response, error in
            DispatchQueue.main.async {
                // Handle client errors
                if let error = error {
                    completion(false, NetworkError.clientError(error))
                    return
                }

                // Handle server errors
                guard
                    let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode)
                else {
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                    completion(false, NetworkError.serverError(statusCode: statusCode))
                    return
                }

                guard let data = imageData else {
                    completion(false, NetworkError.dataError)
                    return
                }

                self?.image = UIImage(data: data)
                completion(true, nil)
            }
        }

        task.resume()
    }

    func loadJsonWithAlamofire(completion: @escaping (Bool, Error?) -> Void) {
        AF.request(jsonApi).response { [weak self] response in
            if let error = response.error {
                completion(false, NetworkError.clientError(error))
                return
            }

            guard let data = response.data else {
                completion(false, NetworkError.dataError)
                return
            }

            self?.json = String(data: data, encoding: .utf8)
            completion(true, nil)
        }
    }
}
