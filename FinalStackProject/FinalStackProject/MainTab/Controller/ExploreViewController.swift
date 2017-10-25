//
//  ExploreViewController.swift
//  1018_Fanxy
//
//  Created by 김기윤 on 20/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var data = DataCenter.mainCenter.exploreDataList
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "All services"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataCenter.mainCenter.exploreDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreTableCell", for: indexPath)
        cell.imageView?.frame = CGRect(x: 8, y: 8, width: 30, height: 30)
        cell.textLabel?.text = data[indexPath.row].itemName
        cell.detailTextLabel?.text = data[indexPath.row].category
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
}
