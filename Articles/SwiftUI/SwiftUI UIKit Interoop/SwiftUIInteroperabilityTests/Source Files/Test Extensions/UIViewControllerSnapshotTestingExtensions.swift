//
//  UIViewControllerSnapshotTestingExtensions.swift
//  SwiftUI Interoperability
//

import UIKit
import XCTest
import SnapshotTesting

extension UIViewController {

    func performSnapshotTests(
        named name: String,
        precision: Float = 0.99,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        assertSnapshot(
            matching: self,
            as: .image(on: .iPhoneX, precision: precision),
            named: name,
            file: file,
            testName: "SwiftUIInteroperability",
            line: line
        )
    }
}
