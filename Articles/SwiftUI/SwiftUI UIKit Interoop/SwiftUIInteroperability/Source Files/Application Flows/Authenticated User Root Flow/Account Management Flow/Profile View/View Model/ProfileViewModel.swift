//
//  ProfileViewModel.swift
//  SwiftUI Interoperability
//

import Foundation
import SwiftUI

// MARK: ProfileViewModel

/// An abstraction describing a View Model for an application initial view.
protocol ProfileViewModel: AnyObject {

    /// A callback to be executed when user has successfully logged out.
    var onLogout: (() -> Void)? { get set }

    /// Logs user out.
    func logOut()
}

// MARK: DefaultProfileViewModel

/// A default implementation of ProfileViewModel.
class LiveProfileViewModel: ObservableObject, ProfileViewModel {

    // MARK: Public Properties

    /// - SeeAlso: NavigableViewModel.onLogout
    var onLogout: (() -> Void)?

    /// User account email.
    @Published var email: String = ""

    // MARK: Private Properties

    private let authenticationService: AuthenticationService
    private let presentableHUD: PresentableHud
    private let infoAlert: InfoAlert
    private let acceptanceAlert: AcceptanceAlert

    // MARK: Initializers

    /// A default ProfileViewModel initializer.
    init(
        authenticationService: AuthenticationService,
        presentableHUD: PresentableHud,
        infoAlert: InfoAlert,
        acceptanceAlert: AcceptanceAlert
    ) {
        self.authenticationService = authenticationService
        self.presentableHUD = presentableHUD
        self.infoAlert = infoAlert
        self.acceptanceAlert = acceptanceAlert
        email = authenticationService.loggedInUser?.email ?? ""
    }

    // MARK: Public methods

    /// - SeeAlso: NavigableViewModel.logOut()
    func logOut() {
        acceptanceAlert.show(
            title: "Logout confirmation",
            message: "Would you like to log out of the application?"
        ) { [weak self] action in
            if action == .yes {
                self?.performLogout()
            }
        }
    }
}

// MARK: Implementation details

private extension LiveProfileViewModel {

    func performLogout() {
        presentableHUD.show(animated: true)
        authenticationService.logout { [unowned self] success in
            presentableHUD.hide(animated: true)
            if success {
                onLogout?()
            } else {
                infoAlert.show(
                    title: "An error has occurred",
                    message: "Please try again later"
                )
            }
        }
    }
}
