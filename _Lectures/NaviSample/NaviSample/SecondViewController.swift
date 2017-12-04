//
//  SecondViewController.swift
//  NaviSample
//
//  Created by youngmin joo on 2017. 10. 11..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let back = UILabel(frame:CGRect(x:100, y: 1000, width:300, height: 40))
        back.text = "<<<"
        back.backgroundColor = .red
        
        let backTitleBtn = UIButton()
        backTitleBtn.setTitle("뒤로", for: .normal)
        backTitleBtn.addTarget(self, action: #selector(self.backHandler(_:)), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(customView:back), UIBarButtonItem(customView:backTitleBtn)]
        

    }

    @objc func backHandler(_ sender:UIButton)
    {
        self.navigationController?.popViewController(animated: true)
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
