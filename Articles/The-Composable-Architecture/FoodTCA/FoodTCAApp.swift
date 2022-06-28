//
//  FoodTCAApp.swift
//  FoodTCA
//
//  Created by Bartosz Dolewski on 27/06/2022.
//

import SwiftUI
import HomeFeature
import DetailsFeature

@main
struct FoodTCAApp: App {
    var body: some Scene {
        WindowGroup {
            HomeScreen(
                store: .init(
                    initialState: .init(),
                    reducer: homeScreenReducer,
                    environment: .live
                ),
                detailsBuilder: { _ in
                    EmptyView()
                }
            )
        }
    }
}
