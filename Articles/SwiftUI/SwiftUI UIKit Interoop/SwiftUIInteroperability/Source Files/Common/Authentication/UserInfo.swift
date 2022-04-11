//
//  UserInfo.swift
//  SwiftUI Interoperability
//

import Foundation

struct UserInfo: Codable {

    let id: String
    let email: String
}

struct UserAuthenticationInfo: Codable, Equatable {

    let email: String
    let password: String
}
