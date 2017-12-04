//
//  SettingViewController.swift
//  MainPageProject
//
//  Created by youngmin joo on 2017. 10. 23..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import UIKit






class SettingViewController: UIViewController {

    private var number:Int = 0
    
    @IBOutlet var table:UITableView!
    
    lazy var dataProvider:SettingProvider = SettingProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SettingViewController:UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}


extension SettingViewController:UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataProvider.settingData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let secctionData = dataProvider.settingData[section]
        
        return secctionData.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let secctionData = dataProvider.settingData[indexPath.section]
        let rowData = secctionData.rows[indexPath.row]
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath) as! MyCustomCell
        cell.cellData = rowData
        
        
        if indexPath.section == 1 && indexPath.row == 0 {
            cell.showVesion()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        guard let cell = tableView.cellForRow(at: indexPath) as? MyCustomCell else {
            return
        }
        let menuType = cell[indexPath.section,indexPath.row]
        
        //        let menuType = settingMenuType(section: indexPath.section, row: indexPath.row)
        
        switch menuType {
        case .InfoMenu:
            let storyboard =  UIStoryboard(name: "Main", bundle: nil)
            let nextVC =  storyboard.instantiateViewController(withIdentifier: "ProfileInfo")
            self.navigationController?.pushViewController(nextVC, animated: true)
        //            self.performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
        case .ChangePW:
            print("next")
        case .Logout:
            //알럿 띄우고
            let alertVC = UIAlertController(title: "Logout", message: "정말 로그아웃 해도 후회 안함니까?", preferredStyle: .alert)
            let action = UIAlertAction(title: "오케이", style: .default, handler: { (action) in
                //오케이 버튼을 클릭했을때 해야될일
                NotificationCenter.default.post(name: Notification.Name.init("logoutNoti"), object: nil)
                
                self.navigationController?.popViewController(animated: true)
                
                UserDefaults.standard.removeObject(forKey: "isLogined")
                
                
            })
            
            
            let cancel = UIAlertAction(title: "아니요", style: .cancel, handler:nil)
            
            alertVC.addAction(action)
            alertVC.addAction(cancel)
            
            self.present(alertVC, animated: true, completion: nil)
            
            
            
        default:
            print("아무일도 안일어남")
        }
        
    }

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let secctionData = dataProvider.settingData[section]
        return secctionData.sectionTitle
    }

    
    
    //    func settingMenuType(section:Int, row:Int) -> MenuType {
    //        if section == 0 {
    //            if row == 0
    //            {return MenuType.InfoMenu}
    //            if row == 1
    //            {return MenuType.ChangePW}
    //            if row == 2
    //            {return MenuType.Logout}
    //        }
    //        return MenuType.Non
    //    }
    
}


