//
//  ViewController.swift
//  1020_CustomTableViewController
//
//  Created by 김기윤 on 20/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CustomCellDelegate {
    
    var onOffList:[Bool] = [true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true]
    
    @IBOutlet var tv: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return onOffList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.switchData = onOffList[indexPath.row]
        cell.textLabel?.text = "\(indexPath.row)" + "Welcome to Delegate World!"
        cell.cellDelegate = self
        cell.indexPath = indexPath
        return cell
    }
    
    
    func customCellSwitched(_ cell: CustomCell, didChangedSwitch value: Bool)
    {
        onOffList[cell.indexPath!.row] = value
    }
    

}

