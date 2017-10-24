//
//  SettingViewController.swift
//  1018_Fanxy
//
//  Created by Kimkeeyun on 20/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SettingCellDelegate {

    var data:SettingDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return DataCenter.mainCenter.settingDataList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data = DataCenter.mainCenter.settingDataList[section]
        return data?.cellContentList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
        data = DataCenter.mainCenter.settingDataList[indexPath.section]
        cell.index = indexPath.row
        cell.data = data!
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = DataCenter.mainCenter.settingDataList[section]
        return section.sectionTitle
    }
    
    func didChangedSwitchValue(_ sender: UISwitch) {
        // switch value changed code in here
    }
    
    
    // Setting - Logout method
    func logout() {
        let mainVC = self.tabBarController as? MainTabBarController
        mainVC?.showLoginGateVC()
    }
    
}
