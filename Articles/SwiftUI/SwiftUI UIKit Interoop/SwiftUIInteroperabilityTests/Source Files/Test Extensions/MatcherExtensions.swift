//
//  MatcherExtensions.swift
//  SwiftUI Interoperability
//

import Mimus
@testable import SwiftUIInteroperability

public extension Matcher where Self: Equatable {

    func matches(argument: Any?) -> Bool {
        compare(other: argument as? Self)
    }
}

extension CacheKey: Matcher {}
extension AuthenticationFlow: Matcher {}
