//
//  DelayedOperationsExecutor.swift
//  SwiftUI Interoperability
//

import UIKit

/// An abstraction for delayed operations executor.
/// Executes blocks of code on a predefined execution queue.
protocol DelayedOperationsExecutor: AnyObject {

    /// Executor type.
    var type: AsynchronousExecutorType { get }

    /// Executes provided code block on predefined execution queue, with a delay.
    ///
    /// - Parameters:
    ///   - delay: a delay.
    ///   - block: a block of code to be executed.
    func executeDelayed(by delay: Double, block: @escaping () -> Void)
}

/// A default DelayedOperationsExecutor implementation.
/// Executes blocks of code on a Main Queue, with a delay.
final class DefaultDelayedAsynchronousBlocksExecutor: DelayedOperationsExecutor {

    /// SeeAlso: DelayedOperationsExecutor.type
    let type: AsynchronousExecutorType = .main

    /// SeeAlso: DelayedOperationsExecutor.executeDelayed()
    func executeDelayed(by delay: Double, block: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            block()
        }
    }
}
