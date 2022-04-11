//
//  MBProgressHUDExtension.swift
//  SwiftUI Interoperability
//

import UIKit
import MBProgressHUD

extension MBProgressHUD {

    /// Shows a preloader view - a loading indicator on a white bezel, with semi-transparent background.
    ///
    /// - Parameters:
    ///   - view: a view to a preloader to.
    ///   - animated: an animation flag.
    /// - Returns: a preloader view.
    class func showPreloaderView(addedTo view: UIView, animated: Bool = true) -> MBProgressHUD {
        let preloaderHud = MBProgressHUD.showLoadingIndicator(addedTo: view, animated: animated)
        preloaderHud.backgroundView.style = .solidColor
        preloaderHud.backgroundView.color = PresentableHudConfiguration.preloaderBackgroundColor
        return preloaderHud
    }

    /// Shows a loading indicator - a rotating image (symbolising loading progress) on a white bezel.
    ///
    /// - Parameters:
    ///   - view: a view to a preloader to.
    ///   - animated: an animation flag.
    /// - Returns: a preloader view.
    class func showLoadingIndicator(addedTo view: UIView, animated: Bool = true) -> MBProgressHUD {
        let loader = RotatingLoaderView(image: PresentableHudConfiguration.loadingIndicatorImage)
        loader.startAnimating()
        loader.loaderImageView.tintColor = PresentableHudConfiguration.loadingIndicatorTintColor
        let progressHud = MBProgressHUD.showCustomHUDAddedToView(view, animated: animated, customView: loader)
        return progressHud
    }

    /// Shows a HUD with a custom view inside.
    ///
    /// - Parameters:
    ///   - view: a view to a preloader to.
    ///   - animated: an animation flag.
    ///   - customView: a view to show in a HUD.
    /// - Returns:
    class func showCustomHUDAddedToView(_ view: UIView, animated: Bool, customView: UIView) -> MBProgressHUD {
        let progressHUD = MBProgressHUD.showAdded(to: view, animated: animated)
        progressHUD.mode = .customView
        progressHUD.bezelView.color = PresentableHudConfiguration.bezelColor
        progressHUD.bezelView.style = .solidColor
        progressHUD.customView = customView
        progressHUD.margin = PresentableHudConfiguration.centralIconMargin
        return progressHUD
    }
}
