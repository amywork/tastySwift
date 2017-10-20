import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CustomCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    var leftIconColorList = [#colorLiteral(red: 1, green: 0.1568113565, blue: 0.2567096651, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1), #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        // SB에서 CustomCell로 register 할 것이기 때문에, 등록하면 됨됨
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataCenter.mainCenter.nameList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.leftIcon.backgroundColor = leftIconColorList[indexPath.row]
        cell.nameLabel.text = DataCenter.mainCenter.nameList[indexPath.row]
        cell.cellDelegate = self
        cell.nameOfIndexPath = cell.nameLabel.text
        return cell
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

    
}

