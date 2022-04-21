//
//  FakeUINavigationController.swift
//  SwiftUI Interoperability
//

import UIKit
import Mimus

@testable import SwiftUIInteroperability

class FakeUINavigationController: UINavigationController, Mock {
    var storage = Storage()
    private(set) var pushedViewControllers: [UIViewController] = []

    override var viewControllers: [UIViewController] {
        get {
            pushedViewControllers
        }
        set {
            recordCall(withIdentifier: "setViewControllers", arguments: [newValue])
        }
    }

    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewControllers.append(viewController)
    }

    override func popViewController(animated: Bool) -> UIViewController? {
        recordCall(withIdentifier: "popViewController", arguments: [animated])
        guard !pushedViewControllers.isEmpty else { return nil }
        pushedViewControllers.removeLast()
        return pushedViewControllers.last
    }
}
