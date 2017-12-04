//
//  TodayViewController.swift
//  WPhotoExtention
//
//  Created by youngmin joo on 2017. 11. 9..
//  Copyright © 2017년 youngmin joo. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet var titleLb:UILabel!
    @IBOutlet var imgView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        let gruopUser = UserDefaults(suiteName: "group.wingjoo.developer.todayextention")
        if let dic = gruopUser?.value(forKey: "FavoritDataKey") as? [String:Any],
            let title = dic["title"] as? String,
            let imgData = dic["data"] as? Data
        {
            //위젯 꾸미기
            self.titleLb.text = title
            self.imgView.image = UIImage(data: imgData)            
        }else
        {
            self.titleLb.text = "좋아하는 사진이 없습니다."
            self.imgView.image = nil
        }

        
        completionHandler(NCUpdateResult.newData)
    }
    
}
