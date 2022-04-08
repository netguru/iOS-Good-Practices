//
//  UserInfo.swift
//  SwiftUI Interoperability
//

import Foundation

struct UserInfo: Codable {

    let id: Int
    let email: String
}

struct UserAuthenticationInfo: Codable {

    let email: String
    let password: String
}
