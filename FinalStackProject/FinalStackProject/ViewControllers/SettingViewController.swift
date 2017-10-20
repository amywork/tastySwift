//
//  SettingViewController.swift
//  1018_Fanxy
//
//  Created by Kimkeeyun on 20/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return DataCenter.mainCenter.settingDataList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = DataCenter.mainCenter.settingDataList[section]
        return section.cellContentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
        let data = DataCenter.mainCenter.settingDataList[indexPath.section]
        cell.textLabel?.text = data.cellContentList[indexPath.row]
        if data.cellTypeList[indexPath.row] == CellType.detail {
            cell.accessoryType = .disclosureIndicator
        }else if data.cellTypeList[indexPath.row] == CellType.withSwitch {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = DataCenter.mainCenter.settingDataList[section]
        return section.sectionTitle
    }
}
