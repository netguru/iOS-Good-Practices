//
//  Food.swift
//  
//
//  Created by Bartosz Dolewski on 28/06/2022.
//

import Foundation

public struct Food {
    let carbs: Int
    let protein: Int
    let fat: Int
    let fiber: Double
    let sugar: Double
    let cholesterol: Double
    let sodium: Double
    let potassium: Double
    let unsaturatedFat: Double
    let saturatedFat: Double
    
    public init(
        carbs: Int,
        protein: Int,
        fat: Int,
        fiber: Double,
        sugar: Double,
        cholesterol: Double,
        sodium: Double,
        potassium: Double,
        unsaturatedFat: Double,
        saturatedFat: Double
    ) {
        self.carbs = carbs
        self.protein = protein
        self.fat = fat
        self.fiber = fiber
        self.sugar = sugar
        self.cholesterol = cholesterol
        self.sodium = sodium
        self.potassium = potassium
        self.unsaturatedFat = unsaturatedFat
        self.saturatedFat = saturatedFat
    }
}
