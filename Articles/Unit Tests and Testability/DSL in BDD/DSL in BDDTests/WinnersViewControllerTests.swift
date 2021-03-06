@testable import DSL_in_BDD
import XCTest

final class WinnersViewControllerTests: XCTestCase {
    
    // MARK: Beginning example
    
    func test_onLoad_showsAllWinners() {
        let sut = makeSUT(for: [winnerOne, winnerTwo, winnerThree])
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 3)
    }
    
    // MARK: Final example
    
    func test_onLoad_showsAllWinners_final() {
        let sut = makeSUT(for: [winnerOne, winnerTwo, winnerThree])
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.winnersDisplayed, 3)
    }
    
    // MARK: Helpers
    
    private func makeSUT(for winners: [Winner] = []) -> WinnersViewController {
        return WinnersViewController(winners)
    }
    
    private var winnerOne: Winner { Winner(name: "winner 1") }
    private var winnerTwo: Winner { Winner(name: "winner 2") }
    private var winnerThree: Winner { Winner(name: "winner 3") }
}

private extension WinnersViewController {
    var winnersDisplayed: Int {
        tableView.numberOfRows(inSection: winnersSection)
    }
    
    var winnersSection: Int { 0 }
}
