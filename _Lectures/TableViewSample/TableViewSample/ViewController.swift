//
//  ViewController.swift
//  TableViewSample
//
//  Created by youngmin joo on 2017. 10. 20..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SwitchTableViewCellDelegate {

    @IBOutlet var tv:UITableView!
    
    var onOffList:[Bool] = [true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true]
    
    @IBAction func switchAction(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tv.tableHeaderView = UIView()        
        tv.tableHeaderView?.backgroundColor = .red
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return onOffList.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SwitchTableViewCell
        
        cell.delegate = self
        cell.textLabel?.text = "\(indexPath.row)"
//        cell.sw.isOn = onOffList[indexPath.row]
        cell.switchData = onOffList[indexPath.row]
        cell.indexPath = indexPath
        
        
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "headerTitle"
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        <#code#>
//    }
    
    
    func switchTableViewCell(_ cell: SwitchTableViewCell, didChangedSwitch value: Bool) {
        print("change Switch \(cell.indexPath!.row)")
        
        onOffList[cell.indexPath!.row] = value
        //영구 저장이 필요시
    }
    
    
        
}

