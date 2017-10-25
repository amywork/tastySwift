//
//  ListViewController.swift
//  1018_Fanxy
//
//  Created by 김기윤 on 20/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var itemTableView: UITableView!
    let friendList = DataCenter.mainCenter.friendList
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataCenter.mainCenter.friendList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Your stacks"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomFriendCell", for: indexPath) as! CustomFriendCell
        cell.data = friendList[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? CustomFriendCell else { return }
        guard let nextVC = segue.destination as? ItemDetailViewController else { return }
        nextVC.data = cell.data
    }

}
