//
//  End2EndTests.swift
//  
//
//  Created by Bartosz Dolewski on 31/05/2022.
//

import XCTest
import Combine
@testable import NetworkClient

final class E2ETests: XCTestCase {
    var disposeBag = Set<AnyCancellable>()

    func test_networkRequestShouldSucceedWithData() throws {
        let exp = expectation(description: "Waiting for response")

        makeSUT()
            .fetchNutritionFacts(1)
            .sink { completion in
                switch completion {
                case .finished:
                    exp.fulfill()
                case let .failure(error):
                    XCTFail("Expected to succeed but failed with error: \(error)")
                    exp.fulfill()
                }
            } receiveValue: { _ in }
            .store(in: &disposeBag)

        wait(for: [exp], timeout: 5.0)
    }

    func makeSUT() -> NetworkClient {
        .live()
    }
}
