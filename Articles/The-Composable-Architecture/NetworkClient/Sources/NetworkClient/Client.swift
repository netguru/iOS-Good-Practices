//
//  Client.swift
//  
//
//  Created by Bartosz Dolewski on 27/06/2022.
//

import Foundation
import Combine

public enum Failure: Error, Equatable {
    case badURL
    case badResponse(Int)
}

public struct NetworkClient {
    public var fetchNutritionFacts: (Int) -> AnyPublisher<Nutrition, Error>
}

public extension NetworkClient {
    static func live(urlSession: URLSession = .shared, jsonDecoder: JSONDecoder = .init()) -> NetworkClient {
        
        return NetworkClient { id in
            guard let url = URL(string: "http://127.0.0.1:8999/nutrition\(id)") else {
                return Fail(error: Failure.badURL)
                    .eraseToAnyPublisher()
            }
 
            return urlSession
                .dataTaskPublisher(for: url)
                .print()
                .tryMap() { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse else {
                        throw URLError(.badServerResponse)
                    }
                    
                    guard httpResponse.statusCode == 200 else {
                        debugPrint(httpResponse)
                        throw Failure.badResponse(httpResponse.statusCode)
                    }
                    
                    return element.data
                }
                .decode(type: Response.self, decoder: jsonDecoder)
                .map(\.nutrition)
                .eraseToAnyPublisher()
        }
    }
}

public extension NetworkClient {
    static let failable = NetworkClient { _ in
        Fail(error: Failure.badURL)
            .eraseToAnyPublisher()
    }
    
    static let successful = NetworkClient { _ in
        Just(Nutrition.mock)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    static let randomSuccessful = NetworkClient { _ in
        Just([Nutrition.mock, .mock2, .mock3].randomElement() ?? Nutrition.mock)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

