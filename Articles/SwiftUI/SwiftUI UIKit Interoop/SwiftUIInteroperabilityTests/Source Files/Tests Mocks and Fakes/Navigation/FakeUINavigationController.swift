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
    private(set) var presentedViewControllers: [UIViewController] = []

    override var viewControllers: [UIViewController] {
        get {
            pushedViewControllers
        }
        set {
            recordCall(withIdentifier: "setViewControllers", arguments: [newValue])
        }
    }

    override var presentedViewController: UIViewController? {
        presentedViewControllers.last
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

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        recordCall(withIdentifier: "present", arguments: [flag])
        presentedViewControllers.append(viewControllerToPresent)
    }

    override func dismiss(animated flag: Bool, completion: (() -> Void)?) {
        recordCall(withIdentifier: "dismiss", arguments: [flag])
        presentedViewControllers.popLast()
    }
}
