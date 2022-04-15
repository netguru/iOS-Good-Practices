//
//  UITabBarExtensions.swift
//  SwiftUI Interoperability
//

import UIKit

extension UITabBar {

    /// Applies default application style.
    func applyDefaultStyle() {
        isTranslucent = false
        shadowImage = UIImage()
        backgroundImage = UIImage()
        backgroundColor = Colors.basicBlack.color
        unselectedItemTintColor = Colors.basicWhite.color
        tintColor = Colors.basicGreen.color
    }
}
