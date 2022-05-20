//
//  CurrencyDetailsView.swift
//  SwiftUI Interoperability
//

import SwiftUI

struct CurrencyDetailsView: View {
    @StateObject var viewModel: LiveCurrencyDetailsViewModel

    var body: some View {
        ScrollView {
            ZStack {

                // MARK: Back button

                BackNavigationView(
                    tint: Colors.basicGreen.color.swiftUIColor,
                    callback: viewModel.goBack
                )

                // MARK: Details view.

                VStack {
                    Spacer()
                    AsyncImage(url: viewModel.currencyDetailsViewConfiguration.iconLink)
                    Text(viewModel.currencyDetailsViewConfiguration.title)
                        .font(.largeTitle)
                    Text(viewModel.currencyDetailsViewConfiguration.subtitle)
                        .font(.title2)
                    Divider()
                        .padding(10)
                    Text(viewModel.currencyDetailsViewConfiguration.description)
                        .font(.callout)

                    if let tags = viewModel.currencyDetailsViewConfiguration.tags {
                        Divider()
                            .padding(10)
                        Text("Tags:")
                            .font(.subheadline)
                        TagsView(columns: 3, tags: tags, tint: Colors.basicGreen.color.swiftUIColor)
                            .padding()
                    }

                    Spacer()
                }
                .padding(10)
            }
        }
    }
}

private extension CurrencyDetailsView {}
