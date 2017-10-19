//
//  ViewController.swift
//  1020_FriendTableView
//
//  Created by 김기윤 on 19/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    let friendList = DataCenter.mainCenter.friendList
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataCenter.mainCenter.friendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        cell.textLabel?.text = friendList[indexPath.row].Nickname
        cell.detailTextLabel?.text = friendList[indexPath.row].MyProfileDescription
        cell.imageView?.image = UIImage(named: friendList[indexPath.row].ProfileImage!)
        
        return cell
    }
    
    

}

