//
//  CurrenciesView.swift
//  SwiftUI Interoperability
//

import SwiftUI

struct CurrenciesView: View {
    @StateObject var viewModel: LiveCurrenciesViewModel
    @State private var selectedItemId: Int?

    var body: some View {
        ZStack {
            //  Loading View:
            if isLoadingInitialData {
                VStack {
                    Text("Loading...")
                }
            }

            //  Alert View:
            if let error = hasLoadingError {
                VStack {
                    Text("Error: \(error)")
                }
            }

            //  Presentation View:
            if let currencies = loadedCurrencies {
                List(currencies) { currency in
                    CurrenciesListCellView(data: currency, selectedItemId: $selectedItemId) { selectedItemId in
                        viewModel.selectCurrency(id: selectedItemId)
                    }
                    .swipeActions(allowsFullSwipe: false) {
                        Button("FAV") {
                            print("FAV \(currency.name)")
                            //  TODO: Implement adding to FAVS
                        }
                        .tint(.red)
                    }
                    .listRowInsets(EdgeInsets())
                }
                .padding(0)
                .offset(.zero)
                .refreshable {
                    viewModel.fetchCurrencies()
                }
            }
        }
        .onAppear {
            selectedItemId = nil
        }
    }
}

private extension CurrenciesView {

    var isLoadingInitialData: Bool {
        viewModel.viewState == .loading
    }

    var hasLoadingError: String? {
        if case let .error(error) = viewModel.viewState {
            return error.localizedDescription
        }
        return nil
    }

    var loadedCurrencies: [CurrenciesListCellData]? {
        switch viewModel.viewState {
        case let .loaded(currencies), let .cached(currencies):
            return currencies
        default:
            return nil
        }
    }
}
