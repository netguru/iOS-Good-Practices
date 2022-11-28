//
//  DetailsScreen.swift
//  FoodTCA
//
//  Created by Bartosz Dolewski on 05/06/2022.
//

import SwiftUI

public struct DetailsScreen: View {
    let food: Food
    
    public init(food: Food) {
        self.food = food
    }
    
    public var body: some View {
        VStack(spacing: 50) {
            Spacer()
            
            Macros(
                carbs: food.carbs,
                protein: food.protein,
                fat: food.fat
            )
            
            HStack(spacing: 20) {
                SecondaryInfoColumn(ingredient: "FIBER", amount: food.fiber)
                
                SecondaryInfoColumn(ingredient: "SUGAR", amount: food.sugar)
                
                SecondaryInfoColumn(ingredient: "CHOLESTEROL", amount: food.cholesterol)
            }
            
            List {
                Row(ingredient: "Sodium", amount: food.sodium)
                Row(ingredient: "Potassium", amount: food.potassium)
                Row(ingredient: "Unsaturated fat", amount: food.unsaturatedFat)
                Row(ingredient: "Saturated fat", amount: food.saturatedFat)
            }
        }
    }
}

struct DetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailsScreen(food:
                .init(
                    carbs: 10,
                    protein: 30,
                    fat: 60,
                    fiber: 0.0,
                    sugar: 0.27,
                    cholesterol: 0.051,
                    sodium: 0.084,
                    potassium: 0.105,
                    unsaturatedFat: 4.012,
                    saturatedFat: 8.295
                )
        )
    }
}

