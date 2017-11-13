//
//  TodayViewController.swift
//  TodayExtension2
//
//  Created by Kimkeeyun on 13/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet var titleLb:UILabel!
    @IBOutlet var imgView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        let gruopUser = UserDefaults(suiteName: "group.wingjoo.developer.todayextension")
        if let dic = gruopUser?.value(forKey: "selectedCardKey") as? [String:Any] {
            print(dic)
            let name = dic["name"] as! String
            //let imgData = dic["data"] as! Data
            self.titleLb.text = name
            //self.imgView.image = UIImage(data: imgData)
        }else {
            print("this")
            self.titleLb.text = "저장한 카드가 없습니다."
            self.imgView.image = nil
        }
        completionHandler(NCUpdateResult.newData)
    }
    
}
