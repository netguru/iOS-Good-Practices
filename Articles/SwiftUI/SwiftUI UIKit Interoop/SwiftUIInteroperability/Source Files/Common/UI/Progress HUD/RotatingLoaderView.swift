//
//  RotatingLoaderView.swift
//  SwiftUI Interoperability
//

import UIKit
import QuartzCore

/// A view presenting rotating loader icon.
final class RotatingLoaderView: UIView {

    // MARK: Properties

    /// An image view holding the loader icon.
    let loaderImageView: UIImageView

    // MARK: Initializers

    /// Initializes a loader with a provided icon.
    ///
    /// - Parameter image: an icon to symbolise loading process.
    init(image: UIImage) {
        loaderImageView = UIImageView(image: image)
        super.init(frame: CGRect.zero)
        addSubview(loaderImageView)
        let constraints = [
            loaderImageView.topAnchor.constraint(equalTo: topAnchor),
            loaderImageView.rightAnchor.constraint(equalTo: rightAnchor),
            loaderImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            loaderImageView.leftAnchor.constraint(equalTo: leftAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }

    // MARK: Methods

    /// Starts rotation animation of the view.
    func startAnimating() {
        let rotateAnimation = CABasicAnimation(keyPath: Constants.animationKeyPath)
        rotateAnimation.fromValue = 0
        rotateAnimation.toValue = CGFloat((Double.pi * 360) / 180)
        rotateAnimation.duration = PresentableHudConfiguration.loadingIndicatorAnimationDuration
        rotateAnimation.repeatCount = .greatestFiniteMagnitude
        layer.add(rotateAnimation, forKey: Constants.animationName)
    }
}

private extension RotatingLoaderView {

    enum Constants {
        static let animationKeyPath = "transform.rotation"
        static let animationName = "360Animation"
    }
}
