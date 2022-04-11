//
//  ProgressHUD.swift
//  SwiftUI Interoperability
//

import UIKit
import MBProgressHUD

// MARK: Abstractions

/// A PresentableHud type.
enum PresentableHudType {

    /// A preloader.
    case preloader

    /// A loading indicator.
    case loadingIndicator
}

/// An abstraction describing a HUD to be displayed to user.
/// A HUD might take different forms: progress indicator, confirmation popover, etc.
protocol PresentableHud: AnyObject {

    /// Shows HUD.
    ///
    /// - Parameter animated: animation flag.
    func show(animated: Bool)

    /// Hides HUD.
    ///
    /// - Parameter animated: animation flag.
    func hide(animated: Bool)
}

// MARK: DefaultPresentableHud

/// A default PresentableHud implementation.
final class DefaultPresentableHud: PresentableHud {

    // MARK: Properties

    /// A HUD type.
    let type: PresentableHudType

    /// An active view provider.
    weak var viewProvider: VisibleViewProvider?

    /// A current HUD reference.
    private(set) var currentHud: MBProgressHUD?

    private let mainQueueExecutor: AsynchronousOperationsExecutor

    // MARK: Initializers

    /// A default initializer for PresentableHud.
    ///
    /// - Parameters:
    ///   - viewProvider: an active view provider.
    ///   - type: a HUD type.
    ///   - mainQueueExecutor: a main queue executor.
    init(
        viewProvider: VisibleViewProvider?,
        type: PresentableHudType = .preloader,
        mainQueueExecutor: AsynchronousOperationsExecutor = MainQueueOperationsExecutor()
    ) {
        self.viewProvider = viewProvider
        self.type = type
        self.mainQueueExecutor = mainQueueExecutor
    }

    // MARK: Public methods.

    /// SeeAlso: PresentableHud.show()
    func show(animated: Bool) {
        mainQueueExecutor.execute { [weak self] in
            guard let self = self else { return }

            guard let presentingView = self.getPresentingView() else {
                print("ProgressHud.show - Unable to show HUD: no presenting view is set")
                return
            }
            if self.currentHud != nil {
                self.currentHud?.hide(animated: false)
            }
            self.currentHud = self.showHud(addedTo: presentingView, type: self.type, animated: animated)
        }
    }

    /// SeeAlso: PresentableHud.hide()
    func hide(animated: Bool) {
        mainQueueExecutor.execute { [weak self] in
            guard let self = self else { return }

            self.currentHud?.hide(animated: animated)
            self.currentHud = nil
        }
    }
}

// MARK: Implementation details

extension DefaultPresentableHud {

    func getPresentingView() -> UIView? {
        viewProvider?.visibleView
    }

    func showHud(addedTo view: UIView, type: PresentableHudType, animated: Bool) -> MBProgressHUD {
        var mbProgressHUD: MBProgressHUD
        switch type {
        case .preloader:
            mbProgressHUD = MBProgressHUD.showPreloaderView(addedTo: view, animated: animated)
        case .loadingIndicator:
            mbProgressHUD = MBProgressHUD.showLoadingIndicator(addedTo: view, animated: animated)
        }
        mbProgressHUD.accessibilityViewIsModal = true
        mbProgressHUD.accessibilityLabel = "LOADING..."
        return mbProgressHUD
    }
}
