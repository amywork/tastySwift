//
//  ViewController.swift
//  OperationSample
//
//  Created by youngmin joo on 2017. 11. 4..
//  Copyright © 2017년 youngmin joo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var mainLb: UILabel!
    
    @IBAction func action(_ sender: Any) {
        
        
        
        
//        gcdTest()
//        gcdTest()
//        mainLb.text = "change"
        
//        gcdTest2()
        useWorkItem()
        print("end")
    }
    
//    var isRunning:Bool = false
//
//    var timer:Timer?
//    var count = 0
//    func longTimeAction()
//    {
//        if timer == nil
//        {
//            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t) in
//                self.mainLb.text = String(self.count)
//                if self.isRunning
//                {
//                    self.count += 1
//                }
//
//            })
//        }
//
//        if !isRunning {
//            isRunning = true
//        }else
//        {
//            isRunning = false
//        }
//    }
    
    func useWorkItem() {
        var value = 10
        
        let workItem = DispatchWorkItem {
            value += 5
        }
        workItem.perform()

        let queue = DispatchQueue.global(qos: .utility)
        queue.async(execute: workItem)
        
        workItem.notify(queue: DispatchQueue.main) {
            print("value = ", value)
        }
    }

    
    func gcdTest2() {
        
        let q1 = DispatchQueue(label: "com.q1", qos: .userInitiated, attributes: .concurrent)
        let q2 = DispatchQueue(label: "com.q2", qos: .default, attributes: .concurrent)
        let q3 = DispatchQueue(label: "com.q3", qos: .background, attributes: .concurrent)
        
        q3.async {
            for n in 1...10000
            {
                print("background", n)
            }
        }
        
        q1.async {
            for n in 1...10000
            {
                print("userInitiated", n)
            }
        }
        
        q2.async {
            for n in 1...10000
            {
                print("default", n)
            }
        }

    }
    
    func gcdTest(){
        
        //        longTimeAction()
        print("//////////START/////////////////")
        
        
        DispatchQueue.main.async {
            print("main",1)
        }
        DispatchQueue.main.async {
            print("main",2)
        }
        DispatchQueue.main.async {
            print("main",3)
        }
        
        print("///////////////////////////")
        
        for n  in 1...100000{
            DispatchQueue.global().sync {
                print("globla",n)
            }
        }
        
        DispatchQueue.main.async {
            print("main",4)
        }
        DispatchQueue.main.async {
            print("main",5)
        }
        DispatchQueue.main.async {
            print("main",6)
        }
        print("//////////END/////////////////")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadImage()
    }

    
    func loadImage()
    {

        self.imgView.imageForURL("https://i.imgur.com/Fv0F4nA.jpg")
        
        
        
//        DispatchQueue.global().async {
//            if let data = try? Data(contentsOf: URL(string:"https://i.imgur.com/Fv0F4nA.jpg")!)
//            {
//                DispatchQueue.main.async {[unowned self] in
//                    self.imgView.image = UIImage(data: data)
//                }
//            }
//        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

var cache:[String:Data] = [:]

extension UIImageView
{
    func imageForURL(_ urlStr:String)
    {
        if cache.keys.contains(urlStr)
        {
            let data = cache[urlStr]!
            self.image = UIImage(data: data)
        }else
        {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: URL(string:urlStr)!)
                {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)
                    }
                    cache.updateValue(data, forKey: urlStr)
                }else
                {
                    DispatchQueue.main.async {
                        
                      //  self.image = UIImage(named:default)
                    }
                }
                
            }
        }
    }
}









//func useWorkItem() {
//    var value = 10
//
//    let workItem = DispatchWorkItem {
//        value += 5
//    }
//
//    workItem.perform()
//
//    let queue = DispatchQueue.global(qos: .utility)
//
//    queue.async(execute: workItem)
//
//
//    workItem.notify(queue: DispatchQueue.main) {
//        print("value = ", value)
//    }
//}

//
//
//let delayQueue = DispatchQueue(label: "com.wing.delayqueue", qos: .userInitiated)
//
//print(Date())
//
//let additionalTime: DispatchTimeInterval = .seconds(2)
//
//delayQueue.asyncAfter(deadline: .now() + additionalTime) {
//    print("additionalTime",Date())
//}
//delayQueue.asyncAfter(deadline: .now() + 0.75) {
//    print("0.85",Date())
//}
//
//useWorkItem()

//
//        print("start")
//
//        let longOperation = BlockOperation {
//            for n in 1...100000000
//            {
//                if n == 100000000
//                {
//                    print(1000)
//                }
//            }
//        }
//
//        let shotOperation = BlockOperation {
//            print("printblock")
//        }
//
//
//
//
//        let mainQueue = OperationQueue()
//
//        mainQueue.addOperation(longOperation)
//        mainQueue.addOperation(shotOperation)
//
//
//
//        let queue = DispatchQueue(label: "myQueue", qos: .default, attributes: .initiallyInactive, autoreleaseFrequency: .inherit, target:nil)
