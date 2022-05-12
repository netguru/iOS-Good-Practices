//
//  ProfileViewController.swift
//  SwiftUI Interoperability
//

import SwiftUI
import UIKit

// MARK: ProfileViewControllerDelegate

protocol ProfileViewControllerDelegate: AnyObject {

    /// Notifies delegate when the user has successfully logged out.
    ///
    /// - Parameter viewController: a view controller.
    func profileViewControllerDidLogOut(_ viewController: UIViewController)
}

// MARK: ProfileViewController

final class ProfileViewController<Content>: UIHostingController<Content> where Content: View {

    // MARK: Public Properties

    weak var delegate: ProfileViewControllerDelegate?

    /// A view model.
    unowned var viewModel: ProfileViewModel

    // MARK: Private Properties

    // MARK: Initializers

    /// A default ProfileViewController initializer.
    ///
    /// - Parameters:
    ///   - view: a SwiftUI view.
    ///   - viewModel: a view model.
    required init(view: Content, viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(rootView: view)
        setupViewModelCallbacks()
    }

    override required init(rootView: Content) {
        fatalError("init(rootView:) has not been implemented")
    }

    @objc dynamic required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle events

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: Implementation details

private extension ProfileViewController {

    func setupViewModelCallbacks() {
        viewModel.onLogout = { [unowned self] in
            delegate?.profileViewControllerDidLogOut(self)
        }
    }
}
