//
//  SomeClass.swift
//  SwizzledUp
//

class SomeClass {
    dynamic func method() {
        print("method")
    }
}

extension SomeClass {
    @_dynamicReplacement(for: method)
    func swizzled_method1() {
        method()
        print("swizzled_method1")
    }

    @_dynamicReplacement(for: method)
    func swizzled_method2() {
        method()
        print("swizzled_method2")
    }
}
