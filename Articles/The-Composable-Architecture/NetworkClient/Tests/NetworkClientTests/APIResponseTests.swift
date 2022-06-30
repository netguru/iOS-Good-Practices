//
//  APIResponseTests.swift
//  
//
//  Created by Bartosz Dolewski on 31/05/2022.
//

import XCTest
@testable import NetworkClient

final class APIResponseTests: XCTestCase {
    let jsonResponse =
    """
    {
        "meta": {
            "code": 200
        },
        "response": {
            "carbs": 3.04,
            "fiber": 0.0,
            "title": "Ricotta cheese",
            "pcstext": "Whole cheese",
            "potassium": 0.105,
            "sodium": 0.084,
            "calories": 174,
            "fat": 12.98,
            "sugar": 0.27,
            "gramsperserving": 20.0,
            "cholesterol": 0.051,
            "protein": 11.26,
            "unsaturatedfat": 4.012,
            "saturatedfat": 8.295
        }
    }
    """.data(using: .utf8)!
    
    func test_whenDataIsValidParsingShouldBeSuccessful() throws {
        let parsedResponse = try JSONDecoder().decode(Response.self, from: jsonResponse)
        
        XCTAssertEqual(parsedResponse.meta.code, 200)
        
        XCTAssertEqual(parsedResponse.nutrition.carbs, 3.04)
        XCTAssertEqual(parsedResponse.nutrition.fiber, 0.0)
        XCTAssertEqual(parsedResponse.nutrition.title, "Ricotta cheese")
        XCTAssertEqual(parsedResponse.nutrition.textDescription, "Whole cheese")
        XCTAssertEqual(parsedResponse.nutrition.gramsPerServing, 20.0)
    }
}
