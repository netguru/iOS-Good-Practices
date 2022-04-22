//
//  UIAlertControllerExtensions.swift
//  SwiftUI Interoperability
//

import UIKit

extension UIAlertController {

    /// Source: https://stackoverflow.com/questions/40628852/how-do-i-cast-an-nsmallocblock-to-its-underlying-type-in-swift-3/50461706#50461706
    typealias AlertHandler = @convention(block) (UIAlertAction) -> Void

    func tapAction(atIndex index: Int) {
        if let block = actions[index].value(forKey: "handler") {
            let blockPtr = UnsafeRawPointer(Unmanaged<AnyObject>.passUnretained(block as AnyObject).toOpaque())
            let handler = unsafeBitCast(blockPtr, to: AlertHandler.self)
            handler(actions[index])
        }
    }
}
