//
//  OnboardingSlide.swift
//  SwiftUI Interoperability
//

import Foundation

/// A structure containing data for an onboarding slide.
struct OnboardingSlide: Codable, Equatable {

    /// A slide title.
    let title: String

    /// A slide message.
    let message: String
}
