//
//  FakeRequests.swift
//  SwiftUI Interoperability
//

import Foundation
import Mimus

@testable import SwiftUIInteroperability

final class FakeGetRequest: NetworkRequest {
    let path: String = "https://absoulte.path.io/api"
    let method: NetworkRequestMethod = .get
    let parameters: [String: Any]? = ["foo": 1, "nextFoo": "bar"]
    let body: [String: Any]? = nil
}

final class FakePostRequest: NetworkRequest {
    let path: String = "/sample/path"
    let method: NetworkRequestMethod = .post
    let body: [String: Any]? = ["foo": 1, "nextFoo": "bar"]
    let additionalHeaderFields: [String: String]? = ["headerName": "fieldValue"]
}
