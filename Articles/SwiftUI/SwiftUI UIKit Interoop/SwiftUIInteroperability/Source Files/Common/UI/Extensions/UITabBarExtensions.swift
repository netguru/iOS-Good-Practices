//
//  UITabBarExtensions.swift
//  SwiftUI Interoperability
//

import UIKit

extension UITabBar {

    /// Applies default application style.
    func applyDefaultStyle() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowImage = UIImage()
        appearance.backgroundImage = UIImage()
        appearance.backgroundColor = Colors.basicBlack.color
        appearance.stackedLayoutAppearance.normal.iconColor = Colors.basicWhite.color
        appearance.stackedLayoutAppearance.selected.iconColor = Colors.basicGreen.color
        standardAppearance = appearance
        scrollEdgeAppearance = appearance
    }
}
