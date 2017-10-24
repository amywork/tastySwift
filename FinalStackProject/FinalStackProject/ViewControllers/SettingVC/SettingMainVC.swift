//
//  SettingViewController.swift
//  1018_Fanxy
//
//  Created by Kimkeeyun on 20/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

enum MenuType {
    case infoMenu
    case changePW
    case logout
    case memberout
    case non
}

class SettingMainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, SettingCellDelegate {

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
        let data = DataCenter.mainCenter.settingDataList[indexPath.section]
        cell.index = indexPath.row
        cell.data = data
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = DataCenter.mainCenter.settingDataList[section]
        return section.sectionTitle
    }
    
    func didChangedSwitchValue(_ sender: UISwitch) {
        // switch value changed code in here
    }
    
    
    // MARK: - didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let menuType = settingMenuType(section: indexPath.section, row: indexPath.row)
        switch menuType {
        case .infoMenu:
            /*guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileInfo") else { return }
            self.navigationController?.pushViewController(nextVC, animated: true)*/
            // Manual Segue로 실행
            performSegue(withIdentifier: "ProfileInfo", sender: self)
        case .logout:
            let alertVC = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
            let logoutAction = UIAlertAction(title: "YES", style: .default, handler: { (action) in
                // Logout
                DataCenter.mainCenter.currentUser = nil
                self.tabBarController?.selectedIndex = 0
                let mainVC = self.tabBarController as? MainTabBarController
                mainVC?.showLoginGateVC()
            })
            let cancelAction = UIAlertAction(title: "CANCEL", style: .default, handler: nil)
            alertVC.addAction(logoutAction)
            alertVC.addAction(cancelAction)
            self.present(alertVC, animated: true, completion: nil)
        case .changePW:
            let alertVC = UIAlertController(title: "비밀번호 변경", message: "비밀번호를 변경하세요", preferredStyle: .alert)
            alertVC.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "Input PWD"
            })
            let changeAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                // Change PWD
                DataCenter.mainCenter.currentUser = nil
            })
            let cancelAction = UIAlertAction(title: "CANCEL", style: .default, handler: nil)
            alertVC.addAction(changeAction)
            alertVC.addAction(cancelAction)
            self.present(alertVC, animated: true, completion: nil)
        case .memberout:
            print("memberout")
        default:
            print("default selected")
        }
    }
    
    func settingMenuType(section: Int, row: Int) -> MenuType {
        if section == 0 {
            if row == 0 {
                return MenuType.infoMenu
            }else if row == 1 {
                return MenuType.changePW
            }else if row == 2 {
                return MenuType.logout
            }else if row == 3 {
                return MenuType.memberout
            }
        }
        return MenuType.non
    }
    
    // MARK: Setting - Logout method
    func logout() {
        let mainVC = self.tabBarController as? MainTabBarController
        mainVC?.showLoginGateVC()
    }
    
}
