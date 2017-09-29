////
////  ViewController.swift
////  0929_TableView
////
////  Created by 김기윤 on 29/09/2017.
////  Copyright © 2017 younari. All rights reserved.
////
//
//import UIKit
//
//class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let tableView: UITableView = UITableView(frame: view.bounds, style: .plain)
//        tableView.dataSource = self // UITableViewDataSource 선언
//        tableView.delegate = self // UITableViewDelegate 선언
//        // class 로서 tableView에 등록
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//        // UITableViewCell.self : class이름.self = 클래스 자체
//        // dequeueReusableCell 얘가 UI를 만들 수 있도록 등록하는 과정
//        
//        view.addSubview(tableView)
//    }
//    
//    let menu: [String] = ["Americano", "Flat White", "Ice Latte", "Vanilla Latte", "Cafe Mocha", "Green tea Latte", "Cacao Latte", "Espresso"]
//    
//    // 테이블뷰에서 Required 함수 2개는 꼭 챙기자.
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return menu.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        //dequeue: que라는 자료구조에서 재사용 cell 데이터를 끄집어내는 것
//        cell.textLabel?.text = "〰️ 👋🏻 \(menu[indexPath.row])" // Optional Chaining
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
//    
//    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//    //        if contentSize.offset.y < 100 {
//    //            data 추가 요청
//    //        }
//    //    }
//    
//}
//
//
