//
//  NavigableViewModel.swift
//  SwiftUI Interoperability
//

import Foundation

// MARK: NavigableViewModel

protocol NavigableViewModel: AnyObject {

    /// A callback to be triggered when the view has requested to be taken off display.
    var onNavigationAwayFromViewRequested: (() -> Void)? { get set }

    /// To be called when a view needs to be taken off display.
    func requestNavigatingAwayFromView()
}

// MARK: NavigableViewModel default implementation.

extension NavigableViewModel {

    /// - SeeAlso: NavigableViewModel.requestNavigatingAwayFromView()
    func requestNavigatingAwayFromView() {
        onNavigationAwayFromViewRequested?()
    }
}
