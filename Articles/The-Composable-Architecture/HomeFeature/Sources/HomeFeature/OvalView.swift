//
//  OvalView.swift
//  
//
//  Created by Bartosz Dolewski on 27/06/2022.
//

import SwiftUI

struct OvalView: View {
    let foodName: String
    let calories: Int
    
    private let gradient = Gradient(colors: [
        Color(red: 243/255, green: 167/255, blue: 78/255),
        Color(red: 237/255, green: 84/255, blue: 96/255)
    ])
    
    private let shadowColor = Color(red: 255/255, green: 102/255, blue: 92/255)
    
    var body: some View {
        ZStack {
        Circle()
            .fill(LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing))
            .shadow(color: shadowColor.opacity(0.33), radius: 24, x: 0, y: 8)
         
            VerticalNutritionInfo(foodName: foodName, calories: calories)
        }
    }
}

struct OvalView_Previews: PreviewProvider {
    static var previews: some View {
        OvalView(foodName: "CASHEWS", calories: 400)
            .frame(width: 271.6, height: 271.6, alignment: .center)
            .padding()
    }
}
