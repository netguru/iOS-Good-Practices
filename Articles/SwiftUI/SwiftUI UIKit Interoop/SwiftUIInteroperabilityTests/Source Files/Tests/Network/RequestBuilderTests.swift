//
//  RequestBuilderTests.swift
//  SwiftUI Interoperability
//

import Foundation
import XCTest
@testable import SwiftUIInteroperability

final class RequestBuilderTest: XCTestCase {
    let fixtureURL = URL(string: "https://fixture.url.com")!
    var sut: LiveRequestBuilder!

    override func setUp() {
        sut = LiveRequestBuilder(baseURL: fixtureURL)
    }

    func testBuildingPostRequest() throws {
        //  given:
        let fixtureRequest = FakePostRequest()

        //  when:
        let urlRequest = sut.build(request: fixtureRequest)

        //  then:
        let body = String(data: urlRequest?.httpBody ?? Data(), encoding: .ascii)
        let bodyDict = body?.dictionary
        let headerFields = urlRequest?.allHTTPHeaderFields
        XCTAssertEqual(fixtureURL.absoluteString + fixtureRequest.path, urlRequest?.url?.absoluteString, "Should create proper URL")
        XCTAssertEqual(urlRequest?.httpMethod, fixtureRequest.method.rawValue.uppercased(), "Should use proper HTTP method")
        XCTAssertEqual(urlRequest?.cachePolicy, fixtureRequest.cachePolicy, "Should use proper cache policy")
        let value1 = try XCTUnwrap(bodyDict?["foo"] as? Int, "Should contain proper first parameter")
        let value2 = try XCTUnwrap(bodyDict?["nextFoo"] as? String, "Should contain proper second parameter")
        XCTAssertEqual(value1, 1, "Should contain proper value of first paratmeter")
        XCTAssertEqual(value2, "bar", "Should contain proper value of second paratmeter")
        XCTAssertEqual(headerFields?["headerName"], "fieldValue", "Should contain proper header field with a value")
    }

    func testBuildingGetRequest() throws {
        //  given:
        let fixtureRequest = FakeGetRequest()

        //  when:
        let urlRequest = sut.build(request: fixtureRequest)

        //  then:
        XCTAssertNil(urlRequest?.httpBody)
        XCTAssertEqual(fixtureRequest.path + "?foo=1&nextFoo=bar", urlRequest?.url?.absoluteString, "Should use absolute URL path from the request")
        XCTAssertEqual(urlRequest?.httpMethod, fixtureRequest.method.rawValue.uppercased(), "Should use proper HTTP method")
        XCTAssertEqual(urlRequest?.cachePolicy, fixtureRequest.cachePolicy, "Should use proper cache policy")
    }
}
