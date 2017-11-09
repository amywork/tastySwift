//
//  TodayWidgetController.swift
//  1108_iOSComponents
//
//  Created by 김기윤 on 09/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class MyCardController: UIViewController, CardCellDelegate {
    
    var currentSelectedCell: CustomCardCell?
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: NSNotification.Name.init("NewCard"), object: nil, queue: nil) { (noti) in
            self.tableView.reloadData()
        }
    }
    
    // MARK : - Prepare Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "CardDetailController" {
            guard let cell = sender as? CustomCardCell else { return }
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
        return DataCenter.main.cardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CustomCardCell
        cell.delegate = self
        cell.data = DataCenter.main.cardList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    func didSelectedCell(_ cell: CustomCardCell) {
        if let selectedCell = currentSelectedCell
        {
            if cell === selectedCell
            {
                cell.data?.isSelected = false
                self.currentSelectedCell = nil
                DataCenter.main.selectedCard = nil
            }else
            {
                selectedCell.data!.isSelected = false
                cell.data!.isSelected = true
                self.currentSelectedCell = cell
                DataCenter.main.selectedCard = cell.data
            }
        }else
        {
            cell.data!.isSelected = true
            self.currentSelectedCell = cell
            DataCenter.main.selectedCard = cell.data
        }
        
    }
    
}
