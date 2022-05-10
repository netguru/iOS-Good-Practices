//
//  ViewControllersTransitionsCoordinator.swift
//  SwiftUI Interoperability
//

import UIKit

/// An abstraction describing transition coordinator for view controllers.
protocol ViewControllersTransitionsCoordinator: AnyObject {

    /// Performs a transition to a provided View Controller with a defined animation.
    ///
    /// - Parameters:
    ///   - viewController: a view controller to transition to
    ///   - animationType: an animation type to be used for a transition.
    func transition(toViewController viewController: UIViewController, animationType: ViewControllerTransitionAnimation)
}

/// A default implementation of ViewControllersTransitionsCoordinator
/// SeeAlso: ViewControllersTransitionsCoordinator
final class LiveViewControllersTransitionsCoordinator: ViewControllersTransitionsCoordinator {

    // MARK: Properties

    /// A factory providing animation blocks for a transition process
    let animationBlocksFactory: ViewControllerTransitionAnimationsFactory

    /// A containing View Controller, on top of which a transition is performed
    private(set) weak var containerViewController: UIViewController?

    /// A currently shown View Controller
    private(set) weak var currentViewController: UIViewController?

    private var currentViewControllerConstraints: [NSLayoutConstraint]?

    // MARK: Initializers

    /// A default initializer for LiveViewControllersTransitionsCoordinator
    ///
    /// - Parameters:
    ///   - containerViewController: a containing View Controller, on top of witch a transition is performed
    ///   - animationBlocksFactory: a factory providing animation blocks for a transition process
    init(
        containerViewController: UIViewController,
        animationBlocksFactory: ViewControllerTransitionAnimationsFactory = LiveViewControllerTransitionAnimationsFactory()
    ) {
        self.containerViewController = containerViewController
        self.animationBlocksFactory = animationBlocksFactory
    }

    // MARK: Public methods

    /// SeeAlso: ViewControllersTransitionsCoordinator.transition()
    func transition(toViewController viewController: UIViewController, animationType: ViewControllerTransitionAnimation) {
        guard let containerViewController = containerViewController else {
            return
        }

        let animated = animationType != .none
        let fromViewController = currentViewController
        let fromView = currentViewController?.view
        let fromViewConstraints = currentViewControllerConstraints
        let containerView: UIView = containerViewController.view
        let toView: UIView = viewController.view
        let preTransitionAnimationBlock = animationBlocksFactory.makePreTransitionAnimationBlock(animationType: animationType, fromView: fromView, toView: toView)
        let postTransitionAnimationBlock = animationBlocksFactory.makePostTransitionAnimationBlock(animationType: animationType, fromView: fromView, toView: toView)

        fromViewController?.willMove(toParent: nil)
        fromViewController?.beginAppearanceTransition(false, animated: animated)
        viewController.beginAppearanceTransition(true, animated: animated)

        containerViewController.beginAppearanceTransition(false, animated: true)
        containerViewController.addChild(viewController)
        containerViewController.view.addSubview(toView)

        if animated {
            preTransitionAnimationBlock?()
        }
        toView.bounds = containerView.bounds
        currentViewControllerConstraints = [
            toView.topAnchor.constraint(equalTo: containerView.topAnchor),
            toView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            toView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            toView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ]

        containerView.layoutIfNeeded()

        let completion: (Bool) -> Void = { _ in
            if let fromViewConstraints = fromViewConstraints {
                NSLayoutConstraint.deactivate(fromViewConstraints)
            }

            fromView?.removeFromSuperview()
            fromViewController?.endAppearanceTransition()
            fromViewController?.removeFromParent()
            containerViewController.endAppearanceTransition()

            viewController.didMove(toParent: self.containerViewController)
            viewController.endAppearanceTransition()

            self.currentViewController = viewController
        }

        if animated {
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                options: [],
                animations: {
                    postTransitionAnimationBlock?()
                },
                completion: completion
            )
        } else {
            completion(true)
        }
    }
}
