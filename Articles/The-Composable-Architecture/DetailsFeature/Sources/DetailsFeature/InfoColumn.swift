//
//  InfoColumn.swift
//  
//
//  Created by Bartosz Dolewski on 28/06/2022.
//

import SwiftUI

struct InfoColumn: View {
    let macro: String
    let percentage: Int
    
    private let fontName = "Avenir-Light"
    private let textColor = Color(red: 108/255, green: 108/255, blue: 108/255)
    
    var body: some View {
        VStack(spacing: 5) {
            Text(macro)
                .foregroundColor(textColor)
                .font(.custom(fontName, size: 14))
            
            Divider()
                .background(.white)
            
            Text("\(percentage)%")
                .foregroundColor(textColor)
                .font(.custom(fontName, size: 14))
        }
        .frame(width: 99.6)
    }
}

struct InfoColumn_Previews: PreviewProvider {
    static var previews: some View {
        InfoColumn(macro: "CARBS", percentage: 10)
            .padding()
    }
}
