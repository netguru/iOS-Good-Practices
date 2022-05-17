//
//  UIViewController+Extensions.swift
//  SwizzledUp
//

import UIKit

extension UIViewController {
    @objc func swizzled_viewWillAppear(_ animated: Bool) {
        swizzled_viewWillAppear(animated)
        let className = String(describing: classForCoder)
        print("[\(className)] viewWillAppear")
    }

    static func swizzleViewWillAppear() {
        let selector1 = #selector(UIViewController.viewWillAppear(_:))
        let selector2 = #selector(UIViewController.swizzled_viewWillAppear(_:))
        guard
            let originalMethod = class_getInstanceMethod(UIViewController.self, selector1),
            let swizzleMethod = class_getInstanceMethod(UIViewController.self, selector2)
        else {
            return
        }
        method_exchangeImplementations(originalMethod, swizzleMethod)
    }
}
