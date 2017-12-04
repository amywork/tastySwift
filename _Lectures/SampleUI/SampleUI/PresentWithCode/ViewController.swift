//
//  ViewController.swift
//  SampleUI
//
//  Created by youngmin joo on 2017. 10. 10..
//  Copyright © 2017년 WingsCompany. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let tv:UITableView = UITableView(frame: view.bounds, style: .plain)
        
        tv.dataSource = self
        tv.delegate = self
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tv)
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "this is Cell"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    /*
     뷰컨트롤러 인스턴스 생성
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //셀 클릭한 후
        //**********usingXib***********//
//        let VC = UsingXibViewController()
//        present(VC, animated: true, completion: nil)
        
        //**********using storyboard***********//
        //////////storyboard 명시적으로 불러오기
        //        let storyboard = UIStoryboard(name: "SubStoryboad", bundle: nil)
        
        //////////같은 스토리 보드내 ViewController불러오기
        guard let secondVC2 = self.storyboard!.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else { return }
        //present modally
        present(secondVC2, animated: true, completion: nil)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}







