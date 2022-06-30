//
//  HomeFeatureTests.swift
//
//
//  Created by Bartosz Dolewski on 27/06/2022.
//

import XCTest
import Combine
@testable import HomeFeature
@testable import NetworkClient
@testable import ComposableArchitecture

final class HomeFeatureTests: XCTestCase {
    let scheduler = DispatchQueue.test
    
    func test_whenHomeScreenIsDisplayed_andNetworkResponseIsOK_nutritionFactsShouldBeAvailable() {
        let sut = makeSUT(networkClient: .successful)
        
        sut.send(.download) {
            $0.nutritionFacts = nil
            $0.downloadingInProgress = true
        }
        
        scheduler.advance()
        
        let expected = Food.map(from: .mock)
        sut.receive(.receivedResponse(.success(expected))) {
            $0.downloadingInProgress = false
            $0.nutritionFacts = expected
        }
    }
    
    func test_whenHomeScreenIsDisplayed_andNetworkResponseIsBad_onlyAlertShouldBePresented() {
        let sut = makeSUT(networkClient: .failable)
        
        sut.send(.download) {
            $0.nutritionFacts = nil
            $0.downloadingInProgress = true
        }
        
        scheduler.advance()
        
        let expected = HomeScreenError.networkIssue("The operation couldn’t be completed. (NetworkClient.Failure error 1.)")
        sut.receive(.receivedResponse(.failure(expected))) {
            $0.downloadingInProgress = false
            $0.nutritionFacts = nil
            $0.alert = .init(
                title: .init("Sorry, we have some trouble getting your nutrition facts: \(expected.localizedDescription)")
            )
        }
    }
    
    func test_tappingMoreInfoButtonShouldPresentDetailsScreen_and_swipingDownShouldDismissDetailsScreen() {
        let sut = makeSUT(networkClient: .successful)
        
        sut.send(.showDetails) {
            $0.presentingDetails = true
        }
        
        sut.send(.dismissDetails) {
            $0.presentingDetails = false
        }
        scheduler.advance()
    }
}

extension HomeFeatureTests {
    func makeSUT(
        initialState: HomeScreenState = .init(),
        networkClient: NetworkClient
    ) -> TestStore<HomeScreenState, HomeScreenState, HomeScreenAction, HomeScreenAction, HomeScreenEnvironment> {

        let testEnvironment = HomeScreenEnvironment(
            networkClient: networkClient,
            mainQueue: self.scheduler.eraseToAnyScheduler()
        )
        
        let store = TestStore(
            initialState: HomeScreenState(),
            reducer: homeScreenReducer,
            environment: testEnvironment
        )
        
        return store
    }
}

