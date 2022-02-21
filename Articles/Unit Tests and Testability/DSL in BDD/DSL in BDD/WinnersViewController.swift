import UIKit

final class WinnersViewController: UITableViewController {
    
    let winners: [Winner]
    
    init(_ winners: [Winner]) {
        self.winners = winners
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return winners.count
    }
    
}

struct Winner {
    let uuid: UUID = UUID()
    let name: String
}
