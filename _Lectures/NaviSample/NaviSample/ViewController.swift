//
//  ViewController.swift
//  NaviSample
//
//  Created by youngmin joo on 2017. 10. 11..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var name:String
    {
        return "joo"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //라지타이틀
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "라쥐"
        
        
        let nextBtn = UIButton()
        nextBtn.setTitle("Next", for: .normal)
        nextBtn.addTarget(self, action: #selector(self.nextBtnHandler(_:)), for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView:nextBtn)
        
    }

    @objc func nextBtnHandler(_ sender:UIButton)
    {
        goToNextVC()
    }
    
    private func goToNextVC()
    {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pushAction()
    {
        let nextVC = UIViewController()
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func popAction()
    {
        self.navigationController?.popViewController(animated: true)
    }
}





