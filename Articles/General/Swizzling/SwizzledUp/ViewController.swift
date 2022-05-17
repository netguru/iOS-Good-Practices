//
//  ViewController.swift
//  SwizzledUp
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // Take a look at flag in Build Settings.
        let someObject = SomeClass()
        someObject.method()
    }
}
