//
//  SegTestViewController.swift
//  SampleUI
//
//  Created by youngmin joo on 2017. 10. 10..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import UIKit

class SegTestViewController: UIViewController {

    var isAbleToNext:Bool = true
    
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func ableToNextSwitch(_ sender: UISwitch) {
        
        isAbleToNext = sender.isOn
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
       
        if identifier == "nextSeconVCSegue"
        {
            return isAbleToNext
        }else
        {
            return false
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("prepare")
        let sendStr = textField.text ?? "noText"
        
        let destinationVC = segue.destination as! SecondViewController
//        destinationVC.sendMsg(sendStr)
        destinationVC.sendedMsg = sendStr
        
    }
    
    @IBAction func dismissCompletion(_ sender:UIStoryboardSegue)
    {
        //unwind segue진행후 작성할 내용
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
