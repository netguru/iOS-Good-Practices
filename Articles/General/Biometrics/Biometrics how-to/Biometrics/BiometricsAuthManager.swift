//
//  BiometricsAuthManager.swift
//  Biometrics how-to
//
//  Created by Jolanta Zakrzewska on 21/02/2022.
//

import LocalAuthentication

enum BiometricType {
    case none
    case touchID
    case faceID
}

protocol BiometricsAuthManager {
    var availableBiometrics: BiometricType { get }
    var canEvaluatePolicy: Bool { get }
    func authenticateUser(completion: @escaping (BiometricResult) -> Void)
}

final class DefaultBiometricsAuthManager {
    private let context: LAContext
    private let loginReason = "localizedReason from evaluatePolicy"
    private let policy: LAPolicy

    init(with policy: LAPolicy) {
        self.policy = policy
        context = LAContext()
        context.localizedReason = "localizedReason from LAContext"
        context.localizedFallbackTitle = "localizedFallbackTitle"
        context.localizedCancelTitle = "localizedCancelTitle"
    }
}

extension DefaultBiometricsAuthManager: BiometricsAuthManager {
    var availableBiometrics: BiometricType {
        let _ = context.canEvaluatePolicy(policy, error: nil)
        switch context.biometryType {
        case .none:
            return .none
        case .touchID:
            return .touchID
        case .faceID:
            return .faceID
        @unknown default:
            return .none
        }
    }

    var canEvaluatePolicy: Bool {
        context.canEvaluatePolicy(policy, error: nil)
    }

    func authenticateUser(completion: @escaping (BiometricResult) -> Void) {
        context.evaluatePolicy(policy, localizedReason: loginReason) { (success, evaluateError) in
            guard !success, let error = evaluateError else  {
                completion(.success)
                return
            }

            switch error {
            case LAError.authenticationFailed: completion(.authenticationFailed)
            case LAError.userCancel: completion(.userCancel)
            case LAError.userFallback: completion(.userFallback)
            case LAError.biometryNotAvailable: completion(.biometryNotAvailable)
            case LAError.biometryNotEnrolled: completion(.biometryNotEnrolled)
            case LAError.biometryLockout: completion(.biometryLockout)
            default: completion(.default)
            }
        }
    }
}
