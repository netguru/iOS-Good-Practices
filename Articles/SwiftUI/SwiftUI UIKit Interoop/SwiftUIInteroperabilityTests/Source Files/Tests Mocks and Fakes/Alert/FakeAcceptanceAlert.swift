//
//  FakeAcceptanceAlert.swift
//  SwiftUI Interoperability
//

import Foundation
import Mimus

@testable import SwiftUIInteroperability

final class FakeAcceptanceAlert: AcceptanceAlert, Mock {
    var storage = Mimus.Storage()

    private var completion: ((AcceptanceAlertAction) -> Void)?

    func show(
        title: String,
        message: String?,
        yesActionTitle: String,
        noActionTitle: String,
        yesActionStyle: UIAlertAction.Style,
        noActionStyle: UIAlertAction.Style,
        completion: ((AcceptanceAlertAction) -> Void)?
    ) {
        recordCall(withIdentifier: "show", arguments: [title, message, yesActionTitle, noActionTitle])
        self.completion = completion
    }

    func dismiss(animated: Bool, withAction action: AcceptanceAlertAction) {
        recordCall(withIdentifier: "dismiss", arguments: [animated, action])
    }
}

extension FakeAcceptanceAlert {

    func simulateAlertDismissed(answer: AcceptanceAlertAction) {
        completion?(answer)
    }
}
