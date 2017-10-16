//
//  ViewController.swift
//  1016_DataModel
//
//  Created by 김기윤 on 16/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var eventList: [EventData] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // List안에 실데이터가 있다고 가정함
        let List = [["String":"String"],["String":"String"]]
        
        for eventDic in List {
            if let dic = EventData(dataDic: eventDic) {
                self.eventList.append(dic)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

