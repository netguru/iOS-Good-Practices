//
//  ViewControllerTransitionAnimationsFactory.swift
//  SwiftUI Interoperability
//

import UIKit

/// An enumeration describing View Controller transition types.
///
/// - forward: animation resembling UINavigationController.push(viewController) effect
/// - none: no animation
enum ViewControllerTransitionAnimation: CaseIterable {
    case forward
    case none
}

/// An abstraction describing a factory producing blocks of code, arranging views before and after the animation.
protocol ViewControllerTransitionAnimationsFactory: AnyObject {

    /// Produces a block of code setting initial state of the views before the animation starts.
    ///
    /// - Parameters:
    ///   - animationType: selected animation type.
    ///   - fromView: currently displayed view (to be taken down).
    ///   - toView: a view to be shown.
    /// - Returns: a block of code setting initial state of the views before the animation starts.
    func makePreTransitionAnimationBlock(animationType: ViewControllerTransitionAnimation, fromView: UIView?, toView: UIView?) -> (() -> Void)?

    /// Produces a block of code setting a state of the views to be achieved at the end of the animation.
    ///
    /// - Parameters:
    ///   - animationType: selected animation type.
    ///   - fromView: currently displayed view (to be taken down).
    ///   - toView: a view to be shown.
    /// - Returns: a block of code setting a state of the views to be achieved at the end of the animation.
    func makePostTransitionAnimationBlock(animationType: ViewControllerTransitionAnimation, fromView: UIView?, toView: UIView?) -> (() -> Void)?
}

/// A default implementation of ViewControllerTransitionAnimationsFactory
/// SeeAlso: ViewControllerTransitionAnimationsFactory
final class LiveViewControllerTransitionAnimationsFactory: ViewControllerTransitionAnimationsFactory {

    // MARK: Public methods

    /// SeeAlso: ViewControllerTransitionAnimationsFactory.makePreTransitionAnimationBlock()
    func makePreTransitionAnimationBlock(animationType: ViewControllerTransitionAnimation, fromView: UIView?, toView: UIView?) -> (() -> Void)? {
        switch animationType {
        case .forward:
            return makeSlideAnimationPreBlock(fromView: fromView, toView: toView, isForward: true)
        case .none:
            return nil
        }
    }

    /// SeeAlso: ViewControllerTransitionAnimationsFactory.makePostTransitionAnimationBlock()
    func makePostTransitionAnimationBlock(animationType: ViewControllerTransitionAnimation, fromView: UIView?, toView: UIView?) -> (() -> Void)? {
        switch animationType {
        case .forward:
            return makeSlideAnimationPostBlock(fromView: fromView, toView: toView, isForward: true)
        case .none:
            return nil
        }
    }
}

// MARK: Private extension

private extension LiveViewControllerTransitionAnimationsFactory {

    func makeSlideAnimationPreBlock(fromView: UIView?, toView: UIView?, isForward: Bool) -> () -> Void {
        let direction: CGFloat = isForward ? 1 : -1
        return {
            if let toView = toView {
                let width: CGFloat = fromView?.frame.size.width ?? toView.frame.size.width
                let origin = CGPoint(x: direction * width, y: 0)
                let size = toView.frame.size
                toView.frame = CGRect(origin: origin, size: size)
            }
        }
    }

    func makeSlideAnimationPostBlock(fromView: UIView?, toView: UIView?, isForward: Bool) -> () -> Void {
        let direction: CGFloat = isForward ? -1 : 1
        return {
            if let toView = toView {
                let width: CGFloat = fromView?.frame.size.width ?? toView.frame.size.width
                let origin = CGPoint(x: direction * width, y: 0)
                let size = toView.frame.size
                toView.frame = CGRect(origin: CGPoint.zero, size: size)
                fromView?.frame = CGRect(origin: origin, size: size)
            }
        }
    }
}
