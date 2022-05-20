//
//  TagsView.swift
//  SwiftUI Interoperability
//

import SwiftUI

struct TagsView: View {
    let columns: Int
    let tags: [String]
    let tint: Color

    var body: some View {
        LazyVGrid(
            columns: gridItems,
            alignment: .center,
            spacing: 5
        ) {
            ForEach(tags, id: \.self) { tag in
                Text(tag)
                    .font(.footnote)
                    .padding()
                    .background(tint)
                    .lineLimit(3)
                    .minimumScaleFactor(0.5)
                    .multilineTextAlignment(.center)
                    .cornerRadius(16)
            }
        }
    }
}

private extension TagsView {

    var gridItems: [GridItem] {
        var items = [GridItem]()
        for _ in 0...columns {
            items.append(GridItem(.flexible()))
        }
        return items
    }
}
