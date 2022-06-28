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
                detailsBuilder: { food in
                    DetailsScreen(food: DetailsFeature.Food.map(from: food))
                }
            )
        }
    }
}

extension DetailsFeature.Food {
    static func map(from food: HomeFeature.Food) -> Self {
        .init(carbs: food.carbs,
              protein: food.protein,
              fat: food.fat,
              fiber: food.details.fiber,
              sugar: food.details.sugar,
              cholesterol: food.details.cholesterol,
              sodium: food.details.sodium,
              potassium: food.details.potassium,
              unsaturatedFat: food.details.unsaturatedFat,
              saturatedFat: food.details.saturatedFat
        )
    }
}
