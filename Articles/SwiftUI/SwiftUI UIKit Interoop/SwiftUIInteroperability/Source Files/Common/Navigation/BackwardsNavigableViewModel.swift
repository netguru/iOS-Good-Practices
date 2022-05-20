//
//  BackwardsNavigableViewModel.swift
//  SwiftUI Interoperability
//

import Foundation

// MARK: BackwardsNavigableViewModel

protocol BackwardsNavigableViewModel: AnyObject {

    /// A callback to be triggered when the view has requested backwards navigation.
    var onBackwardNavigationRequested: (() -> Void)? { get set }

    /// To be called when a view to request backward navigation.
    func goBack()
}

// MARK: BackwardsNavigableViewModel default implementation

extension BackwardsNavigableViewModel {

    /// - SeeAlso: BackwardsNavigableViewModel.goBack()
    func goBack() {
        onBackwardNavigationRequested?()
    }
}
