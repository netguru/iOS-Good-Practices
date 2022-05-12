//
//  main.swift
//  SwiftUI Interoperability
//

import UIKit

/// Convenience function to determine if the app is running Unit Tests
private func isRunningTests() -> Bool {
    let environment = ProcessInfo.processInfo.environment
    if environment["XCTestConfigurationFilePath"] != nil {
        return true
    }
    return false
}

/// Empty Application Delegate
/// Used in Unit Tests
class UnitTestsAppDelegate: UIResponder, UIApplicationDelegate {}

if isRunningTests() {
    _ = UIApplicationMain(
        CommandLine.argc,
        CommandLine.unsafeArgv,
        NSStringFromClass(UIApplication.self),
        NSStringFromClass(UnitTestsAppDelegate.self)
    )
} else {
    _ = UIApplicationMain(
        CommandLine.argc,
        CommandLine.unsafeArgv,
        NSStringFromClass(UIApplication.self),
        NSStringFromClass(AppDelegate.self)
    )
}
