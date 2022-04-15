//
//  AuthenticatedUserFlowCoordinatorName.swift
//  SwiftUI Interoperability
//

import UIKit

/// An authenticated user root flow coordinator names.
enum AuthenticatedUserFlowCoordinatorName: String {
    case currenciesOverview, dashboard, accountManagement

    var tabBarItem: UITabBarItem {
        let item = UITabBarItem(title: nil, image: tabBarIcon, selectedImage: nil)
        return item
    }

    /// An icon for the tab in tab bar.
    var tabBarIcon: UIImage {
        switch self {
        case .dashboard:
            return Asset.Common.TabBar.tabbarIconDashboard.image.tabBarIcon
        case .currenciesOverview:
            return Asset.Common.TabBar.tabbarIconCurrencies.image.tabBarIcon
        case .accountManagement:
            return Asset.Common.TabBar.tabbarIconProfile.image.tabBarIcon
        }
    }
}
