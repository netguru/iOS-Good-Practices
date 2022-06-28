//
//  Reducer.swift
//  
//
//  Created by Bartosz Dolewski on 27/06/2022.
//

import Foundation
import ComposableArchitecture
import NetworkClient

public struct Food: Equatable {
    let name: String
    let calories: Int
    let carbs: Int
    let protein: Int
    let fat: Int
    let details: FoodDetails
    
    static func map(from nutrition: Nutrition) -> Self {
        .init(
            name: nutrition.title,
            calories: nutrition.calories,
            carbs: Int(nutrition.carbs),
            protein: Int(nutrition.protein),
            fat: Int(nutrition.fat),
            details: .init(
                fiber: nutrition.fiber,
                cholesterol: nutrition.cholesterol,
                sugar: nutrition.sugar,
                sodium: nutrition.sodium,
                potassium: nutrition.potassium,
                unsaturatedFat: nutrition.unsaturatedfat,
                saturatedFat: nutrition.saturatedfat
            )
        )
    }
}

struct FoodDetails: Equatable {
    let fiber: Double
    let cholesterol: Double
    let sugar: Double
    let sodium: Double
    let potassium: Double
    let unsaturatedFat: Double
    let saturatedFat: Double
}

public struct HomeScreenState: Equatable {
    var downloadingInProgress: Bool
    var nutritionFacts: Food?
    var presentingDetails: Bool
    var alert: AlertState<HomeScreenAction>?
    
    public init(downloadingInProgress: Bool = false, nutritionFacts: Food? = nil, presentingDetails: Bool = false, alert: AlertState<HomeScreenAction>? = nil) {
        self.downloadingInProgress = downloadingInProgress
        self.nutritionFacts = nutritionFacts
        self.presentingDetails = presentingDetails
        self.alert = alert
    }
}

public enum HomeScreenAction: Equatable {
    case download
    case receivedResponse(Result<Food, HomeScreenError>)
    case showDetails
    case dismissDetails
    case alertDismissed
}

public enum HomeScreenError: Error, Equatable {
    case networkIssue(String)
}

public struct HomeScreenEnvironment {
    var networkClient: NetworkClient
    var mainQueue: AnySchedulerOf<DispatchQueue>
    
    public init(
        networkClient: NetworkClient,
        mainQueue: AnySchedulerOf<DispatchQueue>
    ) {
        self.networkClient = networkClient
        self.mainQueue = mainQueue
    }
}

public extension HomeScreenEnvironment {
    static let live = HomeScreenEnvironment(
        networkClient: .live(),
        mainQueue: .main
    )
    
    static let fallbackForBackendOutage = HomeScreenEnvironment(
        networkClient: .randomSuccessful,
        mainQueue: .main
    )
}

public let homeScreenReducer = Reducer<HomeScreenState, HomeScreenAction, HomeScreenEnvironment> { state, action, environment in
    switch action {
    case .download:
        state.downloadingInProgress = true
        
        let randomId = Int.random(in: 1..<3)
    
        return environment.networkClient.fetchNutritionFacts(randomId)
            .receive(on: environment.mainQueue)
            .map(Food.map(from:))
            .mapError { HomeScreenError.networkIssue($0.localizedDescription) }
            .catchToEffect()
            .map(HomeScreenAction.receivedResponse)
        
    case .receivedResponse(let result):
        state.downloadingInProgress = false
        
        switch result {
        case .success(let food):
            state.nutritionFacts = food
        case .failure(let error):
            state.nutritionFacts = nil
            state.alert = .init(
                title: .init("Sorry, we have some trouble getting your nutrition facts: \(error.localizedDescription)")
            )
        }
        
        return .none
    
    case .showDetails:
        state.presentingDetails = true
        return .none
        
    case .dismissDetails:
        state.presentingDetails = false
        return .none
        
    case .alertDismissed:
        state.alert = nil
        return .none
    }
}
    .debug()

