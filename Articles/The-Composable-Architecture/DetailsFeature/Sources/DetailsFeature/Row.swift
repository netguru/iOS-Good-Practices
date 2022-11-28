//
//  Row.swift
//  
//
//  Created by Bartosz Dolewski on 28/06/2022.
//

import SwiftUI

struct Row: View {
    let ingredient: String
    let amount: Double
    
    private let fontName = "Avenir-Light"
    private let textColor = Color(red: 108/255, green: 108/255, blue: 108/255)
    
    var body: some View {
        HStack() {
            Text(ingredient)
                .foregroundColor(textColor)
                .italic()
                .font(.custom(fontName, size: 12))
            
            Spacer()
            
            Text(String(format: "%.3f", amount))
                .foregroundColor(textColor)
                .font(.custom(fontName, size: 12))
        }
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        Row(ingredient: "Sodium", amount: 0.81)
    }
}
