//
//  APIResponse.swift
//  
//
//  Created by Bartosz Dolewski on 27/06/2022.
//

import Foundation

struct Response: Decodable {
    let meta: Meta
    let nutrition: Nutrition
    
    enum CodingKeys: String, CodingKey {
        case meta = "meta"
        case nutrition = "response"
    }
}

struct Meta: Decodable {
    let code: Int
}

public struct Nutrition: Decodable {
    public let carbs: Double
    public let fiber: Double
    public let title: String
    public let textDescription: String
    public let potassium: Double
    public let sodium: Double
    public let calories: Int
    public let fat: Double
    public let sugar: Double
    public let gramsPerServing: Double
    public let cholesterol: Double
    public let protein: Double
    public let unsaturatedfat: Double
    public let saturatedfat: Double
    
    enum CodingKeys: String, CodingKey {
        case carbs
        case fiber
        case title
        case textDescription = "pcstext"
        case potassium
        case sodium
        case calories
        case fat
        case sugar
        case gramsPerServing = "gramsperserving"
        case cholesterol
        case protein
        case unsaturatedfat
        case saturatedfat
    }
}

extension Nutrition {
    static var mock: Self {
        .init(
            carbs: 3.04,
            fiber: 0.0,
            title: "Ricotta cheese",
            textDescription: "Whole cheese",
            potassium: 0.105,
            sodium: 0.084,
            calories: 175,
            fat: 12.98,
            sugar: 0.27,
            gramsPerServing: 20.0,
            cholesterol: 0.051,
            protein: 11.26,
            unsaturatedfat: 4.012,
            saturatedfat: 8.295
        )
    }
    
    static var mock2: Self {
        .init(
            carbs: 2.0,
            fiber: 0.0,
            title: "Roquefort cheese",
            textDescription: "Package,  (3 oz)",
            potassium: 0.091,
            sodium: 1.809,
            calories: 369,
            fat: 30.64,
            sugar: 0.0,
            gramsPerServing: 15.0,
            cholesterol: 0.09,
            protein: 21.54,
            unsaturatedfat: 9.794,
            saturatedfat: 19.263
        )
    }
    
    static var mock3: Self {
        .init(
            carbs: 0.28,
            fiber: 0.1,
            title: "Pork frankfurter",
            textDescription: "Whole frankfurter",
            potassium: 0.264,
            sodium: 0.816,
            calories: 269,
            fat: 23.68,
            sugar: 0.0,
            gramsPerServing: 76.0,
            cholesterol: 0.066,
            protein: 12.81,
            unsaturatedfat: 13.123,
            saturatedfat: 8.719
        )
    }
}

