//
//  NetworkClientTests.swift
//  
//
//  Created by Bartosz Dolewski on 31/05/2022.
//

import XCTest
import Combine
@testable import NetworkClient


final class NetworkClientTests: XCTestCase {
    let anyError = NSError(domain: "Any error", code: 0, userInfo: nil)
    let anyHTTPURLResponse = HTTPURLResponse(
            url: URL(string: "any-url.com")!,
            mimeType: nil,
            expectedContentLength: 0,
            textEncodingName: nil
        )
    
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
    
    var disposeBag = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        
        URLProtocolStub.startInterceptingRequests()
    }
    
    override func tearDown() {
        super.tearDown()
        
        URLProtocolStub.stopInterceptingRequests()
    }
    
    func test_whenNetworkConnectionFails_thenClientShouldReturnWithError() {
        URLProtocolStub.stub(data: nil, response: nil, error: anyError)
        
        let exp = expectation(description: "Waiting for response")
        
        makeSUT()
            .fetchNutritionFacts(100)
            .sink { completion in
                exp.fulfill()
            } receiveValue: { nutrition in
                XCTFail("Expected to fail but received nutrition data: \(nutrition)")
                exp.fulfill()
            }
            .store(in: &disposeBag)
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_whenRequestFinishSuccesfully_thenClientShouldReturnWithNutritionData() {
        URLProtocolStub.stub(data: jsonResponse, response: anyHTTPURLResponse, error: nil)
        
        let exp = expectation(description: "Waiting for response")
        
        makeSUT()
            .fetchNutritionFacts(100)
            .sink { completion in
                if case let .failure(error) = completion {
                    XCTFail("Expected to succeed but failed with error: \(error)")
                    exp.fulfill()
                }
            } receiveValue: { nutrition in
                XCTAssertEqual(nutrition.title, "Ricotta cheese")
                exp.fulfill()
            }
            .store(in: &disposeBag)
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_whenRequestFailsWithStatusCode401_thenClientShouldReturnWithError() {
        let response401 = HTTPURLResponse(
            url: URL(string: "any-url.com")!,
            statusCode: 401,
            httpVersion: nil,
            headerFields: nil
        )
        
        URLProtocolStub.stub(data: nil, response: response401, error: nil)
        
        let exp = expectation(description: "Waiting for response")
        
        makeSUT()
            .fetchNutritionFacts(100)
            .sink { completion in
                switch completion {
                case .finished:
                    exp.fulfill()
                case let .failure(error):
                    if let error = error as? Failure {
                        XCTAssertEqual(error, .badResponse(401))
                    } else {
                        XCTFail("Expected to fail as \(Failure.self) but got \(error)")
                    }
                    exp.fulfill()
                }
            } receiveValue: { nutrition in
                XCTFail("Expected to fail but received nutrition data: \(nutrition)")
                exp.fulfill()
            }
            .store(in: &disposeBag)
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func makeSUT() -> NetworkClient {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        
        return NetworkClient.live(urlSession: .init(configuration: configuration))
    }
}

extension NetworkClientTests {
    class URLProtocolStub: URLProtocol {
        static func stub(data: Data?, response: URLResponse?, error: Error? = nil) {
            stub = Stub(data: data, response: response, error: error)
        }
        
        static func startInterceptingRequests() {
            URLProtocol.registerClass(URLProtocolStub.self)
        }
        
        static func stopInterceptingRequests() {
            URLProtocol.unregisterClass(URLProtocolStub.self)
            stub = nil
        }
        
        override func startLoading() {
            if let data = URLProtocolStub.stub?.data {
                client?.urlProtocol(self, didLoad: data)
            }
            
            if let response = URLProtocolStub.stub?.response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            
            if let error = URLProtocolStub.stub?.error {
                client?.urlProtocol(self, didFailWithError: error)
            }
            
            client?.urlProtocolDidFinishLoading(self)
        }
        
        override class func canInit(with request: URLRequest) -> Bool {
            true
        }
        
        override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
        override func stopLoading() {}
        
        private struct Stub {
            let data: Data?
            let response: URLResponse?
            let error: Error?
        }
        
        private static var stub: Stub?
    }
}
