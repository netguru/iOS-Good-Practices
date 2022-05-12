//
//  OnboardingViewController.swift
//  SwiftUI Interoperability
//

import UIKit
import SwiftUI

// MARK: OnboardingViewControllerDelegate

/// An onboarding view controller delegate.
protocol OnboardingViewControllerDelegate: AnyObject {

    /// Notifies delegate when onboarding view requested to be taken off display.
    ///
    /// - Parameter viewController: a view controller.
    func onboardingViewControllerDidFinish(_ viewController: UIViewController)
}

// MARK: OnboardingViewController

class OnboardingViewController<Content>: UIHostingController<Content> where Content: View {

    /// A delegate.
    weak var delegate: OnboardingViewControllerDelegate?

    /// A view model.
    unowned var viewModel: OnboardingViewModel

    /// A default OnboardingViewController initializer.
    ///
    /// - Parameters:
    ///   - view: a SwiftUI view.
    ///   - viewModel: a view model.
    required init(view: Content, viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(rootView: view)
        setupViewModelCallbacks()
    }

    @available(*, unavailable)
    override required init(rootView: Content) {
        fatalError("init(rootView:) has not been implemented")
    }

    @available(*, unavailable)
    @objc dynamic required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Implementation details

private extension OnboardingViewController {

    func setupViewModelCallbacks() {
        viewModel.onNavigationAwayFromViewRequested = { [unowned self] in
            delegate?.onboardingViewControllerDidFinish(self)
        }
    }
}
