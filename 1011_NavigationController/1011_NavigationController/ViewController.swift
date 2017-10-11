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
        
        let nextBtn = UIButton()
        nextBtn.setTitle("🙃👉🏻", for: .normal)
        nextBtn.addTarget(self, action: #selector(nextBtnHandler), for: .touchUpInside)        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: nextBtn)
    }
    
    @objc func nextBtnHandler(){
        pushSecond()
    }
    
    private func pushSecond() {
        let nextVC: SecondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC: SecondViewController = segue.destination as! SecondViewController
        nextVC.labelStr = "Text changed succesfully"
    }
    
    @IBAction func pushHandler(_ sender: Any) {
        let nextVC: SecondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func popAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
