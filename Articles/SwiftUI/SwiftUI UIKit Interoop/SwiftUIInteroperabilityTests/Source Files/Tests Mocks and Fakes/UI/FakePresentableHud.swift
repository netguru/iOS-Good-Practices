//
//  FakePresentableHud.swift
//  SwiftUI Interoperability
//

import Foundation
import Mimus

@testable import SwiftUIInteroperability

final class FakePresentableHud: PresentableHud, Mock {
    var storage = Mimus.Storage()

    func show(animated: Bool) {
        recordCall(withIdentifier: "show", arguments: [animated])
    }

    func hide(animated: Bool) {
        recordCall(withIdentifier: "hide", arguments: [animated])
    }
}
