//
//  BiometricResult.swift
//  Biometrics how-to
//
//  Created by Jolanta Zakrzewska on 21/02/2022.
//

import LocalAuthentication

enum BiometricResult: String {
    case success = "Authentication ended successfully!"
    case authenticationFailed = "There was a problem verifying your identity."
    case userCancel = "You pressed cancel."
    case userFallback = "You selected fallback."
    case biometryNotAvailable = "Face ID/Touch ID is not available."
    case biometryNotEnrolled = "Face ID/Touch ID is not set up."
    case biometryLockout = "Face ID/Touch ID is locked."
    case `default` = "Face ID/Touch ID may not be configured"
}
