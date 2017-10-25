//
//  ProfileInfoVC.swift
//  FinalStackProject
//
//  Created by 김기윤 on 24/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class ProfileInfoVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Accounts"
        }else if section == 1 {
            return "Toggle Subscriptions"
        }
        return ""
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileInfoCell", for: indexPath)
        cell.textLabel?.text = "Table Cell Title"
        return cell
    }

}
