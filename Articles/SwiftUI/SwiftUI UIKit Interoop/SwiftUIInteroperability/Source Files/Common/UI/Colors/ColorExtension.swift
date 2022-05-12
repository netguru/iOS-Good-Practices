//
//  ColorExtension.swift
//  SwiftUI Interoperability
//

import UIKit

extension UIColor {

    ///
    /// Preloader colors:
    ///

    class var preloaderBackgroundColor: UIColor {
        Colors.basicBlack.color.withAlphaComponent(0.25)
    }

    class var preloaderBezelColor: UIColor {
        Colors.basicWhite.color.withAlphaComponent(0.9)
    }

    class var preloaderIndicatorColor: UIColor {
        Colors.basicGreen.color
    }
}

extension UIColor {

    /// Initializes a color with a red, green and blue values.
    ///
    /// - Parameters:
    ///   - red: red color value.
    ///   - green: green color value.
    ///   - blue: blue color value.
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    /// Initializes a color with a rgb value.
    ///
    /// - Parameters:
    ///   - rgb: color value in rgb spectrum.
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
