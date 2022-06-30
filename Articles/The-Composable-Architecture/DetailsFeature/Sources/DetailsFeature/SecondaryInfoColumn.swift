//
//  SecondaryInfoColumn.swift
//  
//
//  Created by Bartosz Dolewski on 28/06/2022.
//

import SwiftUI

struct SecondaryInfoColumn: View {
    let ingredient: String
    let amount: Double
    
    private let fontName = "Avenir-Light"
    private let textColor = Color(red: 108/255, green: 108/255, blue: 108/255)
    
    var body: some View {
        VStack(spacing: 5) {
            Text(ingredient)
                .foregroundColor(textColor)
                .font(.custom(fontName, size: 14))
            
            Divider()
                .background(.white)
            
            Text(String(format: "%.3f", amount))
                .foregroundColor(textColor)
                .font(.custom(fontName, size: 14))
        }
        .frame(width: 99.6)
    }
}

struct SecondaryInfoColumn_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryInfoColumn(ingredient: "CHOLESTEROL", amount: 0.051)
            .padding()
    }
}
