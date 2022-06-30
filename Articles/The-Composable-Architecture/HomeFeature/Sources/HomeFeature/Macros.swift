//
//  Macros.swift
//  
//
//  Created by Bartosz Dolewski on 27/06/2022.
//

import SwiftUI

struct Macros: View {
    let carbs: Int
    let protein: Int
    let fat: Int
    
    var body: some View {
        HStack(spacing: 20) {
            InfoColumn(macro: "CARBS", percentage: carbs)
            
            InfoColumn(macro: "PROTEIN", percentage: protein)
            
            InfoColumn(macro: "FAT", percentage: fat)
        }
    }
}

struct Macros_Previews: PreviewProvider {
    static var previews: some View {
        Macros(carbs: 10, protein: 60, fat: 30)
            .padding()
    }
}

