//
//  MainViewController.swift
//  1116_HTTPRequestSample
//
//  Created by 김기윤 on 16/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class MyCardController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    private var cardList: [CardData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        cardList = DataCenter.shared.cardList
        NotificationCenter.default.addObserver(forName: Notification.Name.AddCardDataNotification, object: nil, queue: nil) { (noti) in
            self.tableView.reloadData()
        }
    }

}

// MARK : - TableView DataSource
extension MyCardController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Cards"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CustomCardCell
        //cell.data = DataCenter.shared.cardList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
