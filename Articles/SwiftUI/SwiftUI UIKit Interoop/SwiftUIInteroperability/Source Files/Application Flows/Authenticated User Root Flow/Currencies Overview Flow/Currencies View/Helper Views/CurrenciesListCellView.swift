//
//  CurrenciesListCellView.swift
//  SwiftUI Interoperability
//

import SwiftUI

struct CurrenciesListCellView: View {
    let data: CurrenciesListCellData
    @Binding var selectedItemId: Int?
    var onViewTapped: ((Int) -> Void)?

    var body: some View {
        ZStack {
            if isSelected {
                RoundedRectangle(cornerRadius: 2)
                    .fill(Color(Colors.basicGreen.color))
                    .animation(.easeIn, value: 0.5)
            }

            HStack(spacing: 5) {
                Text(data.name)
                    .font(.title)
                    .frame(width: 70, alignment: .leading)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .scaledToFit()
                    .padding([.trailing], 5)
                Text(data.description)
                    .font(.body)
                    .lineLimit(1)
                Spacer()
                Text(data.price)
                    .font(.headline)
                    .frame(width: 100, alignment: .trailing)
                    .lineLimit(1)
            }
            .padding([.top, .bottom], 5)
            .padding([.leading, .trailing], 10)
            .onTapGesture {
                if isSelected {
                    selectedItemId = nil
                } else {
                    onViewTapped?(data.id)
                    selectedItemId = data.id
                }
            }
        }
    }
}

private extension CurrenciesListCellView {

    var isSelected: Bool {
        selectedItemId == data.id
    }
}
