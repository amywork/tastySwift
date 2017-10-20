//
//  ViewController.swift
//  1020_FriendTableView
//
//  Created by 김기윤 on 19/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mainTableView: UITableView!
    let friendList = DataCenter.mainCenter.friendList

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataCenter.mainCenter.friendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomFriendCell", for: indexPath) as! CustomFriendCell
        cell.data = friendList[indexPath.row]
//        cell.textLabel?.text = friendList[indexPath.row].nickName
//        cell.detailTextLabel?.text = friendList[indexPath.row].statusDescription
//        cell.imageView?.image = UIImage(named: friendList[indexPath.row].profileImageName)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? CustomFriendCell else { return }
        guard let nextVC = segue.destination as? DetailViewController else { return }
        nextVC.data = cell.data
    }
    
    
}

