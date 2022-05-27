//
//  FakeWindowController.swift
//  SwiftUI Interoperability
//

import Foundation
import Mimus

@testable import SwiftUIInteroperability

final class FakeWindowController: WindowController, Mock {
    var storage = Mimus.Storage()
    var simulatedVisibleViewController: UIViewController?
    var simulatedVisibleView: UIView?

    func makeAndPresentInitialViewController() {
        recordCall(withIdentifier: "makeAndPresentInitialViewController")
    }

    func startInitialApplicationFlow() {
        recordCall(withIdentifier: "startInitialApplicationFlow")
    }

    var visibleViewController: UIViewController {
        simulatedVisibleViewController ?? UIViewController()
    }

    var visibleView: UIView {
        simulatedVisibleView ?? UIView(frame: .zero)
    }
}
