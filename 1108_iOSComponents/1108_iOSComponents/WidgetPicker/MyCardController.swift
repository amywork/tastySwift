//
//  TodayWidgetController.swift
//  1108_iOSComponents
//
//  Created by 김기윤 on 09/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class MyCardController: UIViewController {

    var selectedCard: CardData?
    lazy var cardList = DataCenter.main.cards
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sampleCard1 = CardData(name: "CJ Point", imgName: "blue")
        let sampleCard2 = CardData(name: "SK Point", imgName: "yellow")
        let sampleCard3 = CardData(name: "Apple Point", imgName: "red")
        let sampleCard4 = CardData(name: "Samsung Point", imgName: "green")
        DataCenter.main.addCard(card: sampleCard1)
        DataCenter.main.addCard(card: sampleCard2)
        DataCenter.main.addCard(card: sampleCard3)
        DataCenter.main.addCard(card: sampleCard4)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didTakeNotification(notification:)), name: NSNotification.Name.init("NewCard"), object: nil)

    }
    
    @objc func didTakeNotification(notification: Notification) {
        if let newCard = notification.object as? CardData {
            self.cardList.append(newCard)
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func didTapStarBtn(_ sender: UIButton) {
        
    }
    
    // MARK : - Prepare Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "CardDetailController" {
            guard let cell = sender as? CardCell else { return }
            guard let nextVC = segue.destination as? CardDetailController else { return }
            nextVC.data = cell.data
        }
        
    }

}

// MARK : - TableView DataSource
extension MyCardController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Cards"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CardCell
        cell.data = cardList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
