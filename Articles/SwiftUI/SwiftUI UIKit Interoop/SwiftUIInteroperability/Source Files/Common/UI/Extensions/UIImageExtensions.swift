//
//  UIImageExtensions.swift
//  SwiftUI Interoperability
//

import UIKit

extension UIImage {

    /// An image rsize mode.
    enum ContentMode {
        case contentFill
        case contentAspectFill
        case contentAspectFit
    }

    /// Resizes an image based on a provided content mode.
    /// 
    /// - Parameters:
    ///   - size: an image size.
    ///   - contentMode: an image content mode.
    /// - Returns:
    func resize(withSize size: CGSize, contentMode: ContentMode = .contentAspectFill) -> UIImage? {
        let aspectWidth = size.width / self.size.width
        let aspectHeight = size.height / self.size.height

        switch contentMode {
        case .contentFill:
            return resize(withSize: size)
        case .contentAspectFit:
            let aspectRatio = min(aspectWidth, aspectHeight)
            return resize(withSize: CGSize(width: self.size.width * aspectRatio, height: self.size.height * aspectRatio))
        case .contentAspectFill:
            let aspectRatio = max(aspectWidth, aspectHeight)
            return resize(withSize: CGSize(width: self.size.width * aspectRatio, height: self.size.height * aspectRatio))
        }
    }

    /// A tab bar icon representation of an image.
    var tabBarIcon: UIImage {
        let tabSize = CGSize(width: 25, height: 25)
        return withRenderingMode(.alwaysTemplate).resize(withSize: tabSize)!
    }
}

private extension UIImage {

    func resize(withSize size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
