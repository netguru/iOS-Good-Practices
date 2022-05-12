//
//  PresentableHudConfiguration.swift
//  SwiftUI Interoperability
//

import UIKit

/// A configuration for Presentable Hud component.
enum PresentableHudConfiguration {

    /// An image to be shown as a loading indicator.
    static let loadingIndicatorImage = Asset.Common.ProgressHUD.spinner.image.withRenderingMode(.alwaysTemplate)

    /// A loading indicator image tint.
    static let loadingIndicatorTintColor = UIColor.preloaderIndicatorColor

    /// A loading indicator animation duration.
    static let loadingIndicatorAnimationDuration = Double(1)

    /// A preloader background color.
    static let preloaderBackgroundColor = UIColor.preloaderBackgroundColor

    /// A bezel color.
    static let bezelColor = UIColor.preloaderBezelColor

    /// A margin to be applied to a central HUD icon, eg. loading indicator image.
    static let centralIconMargin = CGFloat(30)
}
