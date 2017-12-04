//
//  SecondViewController.swift
//  SampleUI
//
//  Created by youngmin joo on 2017. 10. 10..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var displayLb: UILabel!
    
    var sendedMsg:String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let closeBtn = UIButton(type: .system)
//        closeBtn.frame = CGRect(x: 50, y: 50, width: 50, height: 30)
//        closeBtn.setTitle("닫기", for: .normal)
//        closeBtn.setTitleColor(.white, for: .normal)
//        closeBtn.addTarget(self, action: #selector(self.close(_:)), for: .touchUpInside)
//
//        view.addSubview(closeBtn)
//
        print("viwdidload")
        
        displayLb.text = sendedMsg
        
    }

    func sendMsg(_ msg:String)
    {
        sendedMsg = msg
        print("sendMsg")
        
        //나를 프렌젠트 한 ViewController
        let beforVC = presentingViewController
        //내가 프레젠트한 ViewController
        let nextVC = presentedViewController
    }
    
    
    @objc func close(_ sender:UIButton) {
    
        //dissmiss
        dismiss(animated: true, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
