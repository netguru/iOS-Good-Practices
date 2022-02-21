@testable import iOS_Good_Practices
import XCTest

final class WinnersViewControllerTests: XCTestCase {
    
    func test_onLoad_showsAllWinners() {
        let sut = makeSUT(for: [winnerOne, winnerTwo, winnerThree])
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 3)
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
