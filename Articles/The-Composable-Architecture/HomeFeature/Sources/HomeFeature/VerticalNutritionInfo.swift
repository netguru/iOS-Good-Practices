//
//  VerticalNutritionInfo.swift
//  
//
//  Created by Bartosz Dolewski on 27/06/2022.
//


import SwiftUI

struct VerticalNutritionInfo: View {
    let foodName: String
    let calories: Int
    private let fontName = "Avenir-Light"
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Text(foodName)
                    .font(.custom(fontName, size: 16))
                    .foregroundColor(.white)
                
                RoundedRectangle(cornerRadius: 50)
                    .foregroundColor(.white)
                    .frame(height: 2, alignment: .center)
                    .padding(.horizontal, 100)
            }
            
            Text("\(calories)")
                .font(.custom(fontName,fixedSize: 52))
                .foregroundColor(.white)
            
            Text("Calories per serving")
                .font(.custom(fontName,fixedSize: 14))
                .foregroundColor(.white)
                .italic()
        }
    }
}

struct VerticalNutritionInfo_Previews: PreviewProvider {
    static var previews: some View {
        VerticalNutritionInfo(foodName: "CASHEWS", calories: 400)
            .padding()
    }
}

