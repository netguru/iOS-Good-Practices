//
//  MoreInfoButton.swift
//  
//
//  Created by Bartosz Dolewski on 27/06/2022.
//

import SwiftUI

struct MoreInfoButton: View {
    let action: () -> Void
    
    private let gradient = Gradient(colors: [
        Color(red: 1/255, green: 5/255, blue: 33/255),
        Color(red: 2/255, green: 6/255, blue: 39/255)
    ])
    
    private let fontName = "Avenir-Light"
    
    var body: some View {
        Button {
            action()
        } label: {
            Text("MORE INFO")
                .frame(width: 287, height: 75, alignment: .center)
                .padding()
                .font(.custom(fontName, size: 34))
                .background(LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing))
                .foregroundColor(Color.white)
                .cornerRadius(100)
                .shadow(color: .black.opacity(0.33), radius: 27, x: 0, y: 16)
        }
    }
}

struct MoreInfoButton_Previews: PreviewProvider {
    static var previews: some View {
        MoreInfoButton {}
    }
}

