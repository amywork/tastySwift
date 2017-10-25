//
//  SettingViewController.swift
//  1018_Fanxy
//
//  Created by Kimkeeyun on 20/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class SettingMainVC: UIViewController {
    
    // MARK: - Data Property
    var data:SettingDataModel?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK - Methods
extension SettingMainVC {
    func logout() {
        let mainVC = self.tabBarController as? MainTabBarController
        mainVC?.showLoginGateVC()
    }
}

// MARK - Custom Cell Delegate
extension SettingMainVC: SettingCellDelegate {
    func didChangedSwitchValue(_ sender: UISwitch) {
        // switch value changed code in here
    }
}

// MARK: - TableView Source
extension SettingMainVC: UITableViewDelegate, UITableViewDataSource {
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
    
    // MARK: - didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // deselect cell
        tableView.deselectRow(at: indexPath, animated: true)
        
        // cellMenuType (subscript grammar)
        let cell = tableView.cellForRow(at: indexPath) as? SettingTableViewCell
        let cellMenuType = cell?[indexPath.section, indexPath.row]
        switch cellMenuType {
        case .infoMenu?:
            /*SB instantiate으로 실행*/
            /*guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileInfoVC") else { return }
             self.navigationController?.pushViewController(nextVC, animated: true)*/
            
            /*Manual Segue로 실행*/
            performSegue(withIdentifier: "ProfileInfoVC", sender: self)
        case .logout?:
            let alertVC = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
            let logoutAction = UIAlertAction(title: "YES", style: .default, handler: { (action) in
                // Logout
                DataCenter.mainCenter.currentUser = nil
                self.tabBarController?.selectedIndex = 0
                //                let mainVC = self.tabBarController as? MainTabBarController
                //                mainVC?.showLoginGateVC()
                NotificationCenter.default.post(name: NSNotification.Name.init("LogOut"), object: nil)
            })
            let cancelAction = UIAlertAction(title: "CANCEL", style: .default, handler: nil)
            alertVC.addAction(logoutAction)
            alertVC.addAction(cancelAction)
            self.present(alertVC, animated: true, completion: nil)
        case .changePW?:
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
        case .memberout?:
            performSegue(withIdentifier: "ProfileInfoVC", sender: self)
        default:
            print("default selected")
        }
    }
}
