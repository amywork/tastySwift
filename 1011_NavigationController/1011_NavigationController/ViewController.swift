//
//  ViewController.swift
//  1011_NavigationController
//
//  Created by 김기윤 on 11/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC: itemDetailViewController = segue.destination as! itemDetailViewController
        nextVC.labelStr = "Text changed succesfully"
    }
    
    @IBAction func pushHandler(_ sender: Any) {
        let nextVC: itemDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "itemDetailViewController") as! itemDetailViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func popAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
