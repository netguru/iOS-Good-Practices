//
//  HomeScreen.swift
//  
//
//  Created by Bartosz Dolewski on 27/06/2022.
//

import SwiftUI
import ComposableArchitecture
import NetworkClient

struct HomeScreen<DetailsScreen: View>: View {
    let store: Store<HomeScreenState, HomeScreenAction>
    let detailsScreen: (Food) -> DetailsScreen
    
    init(store: Store<HomeScreenState, HomeScreenAction>, @ViewBuilder detailsBuilder: @escaping (Food) -> DetailsScreen) {
        self.store = store
        self.detailsScreen = detailsBuilder
    }
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(spacing: 0) {
                switch viewStore.nutritionFacts {
                case .some(let food):
                    OvalView(
                        foodName: food.name,
                        calories: food.calories
                    )
                    .frame(width: 271.6, height: 271.6, alignment: .center)
                    .padding([.top], 100)
                    .padding([.bottom], 50)
                    
                    Macros(
                        carbs: food.carbs,
                        protein: food.protein,
                        fat: food.fat
                    )
                    
                    Spacer()
                    
                    MoreInfoButton {
                        viewStore.send(.showDetails)
                    }
                    .sheet(isPresented: viewStore.binding(get: \.presentingDetails, send: .dismissDetails)) {
                        detailsScreen(food)
                    }
                    
                    Spacer()
                case .none:
                    ProgressView("Waiting for data")
                }
            }
            .onAppear {
                viewStore.send(.download)
            }
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                viewStore.send(.download)
            }
            .alert(store.scope(state: \.alert), dismiss: .alertDismissed)
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(
            store: .init(
                initialState: .init(),
                reducer: homeScreenReducer,
                environment: .init(
                    networkClient: .successful,
                    mainQueue: .main
                )
            ), detailsBuilder: { _ in EmptyView() }
        )
    }
}
