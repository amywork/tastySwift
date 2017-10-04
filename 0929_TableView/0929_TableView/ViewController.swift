//
//  ViewController.swift
//  0929_TableView
//
//  Created by 김기윤 on 29/09/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tableView: UITableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self // UITableViewDataSource 선언
        tableView.delegate = self // UITableViewDelegate 선언
        
        // class 로서 tableView에 등록
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        // UITableViewCell.self : class이름.self = 클래스 자체
        // dequeueReusableCell 얘가 UI를 만들 수 있도록 등록하는 과정
        view.addSubview(tableView)
    }
    
    let menu: [String] = ["1", "2", "3", "4", "5"]
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // 테이블뷰에서 Required method 2개는 꼭 챙기자.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    //dequeueReusableCell에 reuse할게 없으면 Cell에서 cell을 인스턴스로 만든다.
    //index를 찾아서 cell을 만들어주는 method
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //tableView cell을 만들어서 이름을 집어넣고, 아래는 custom cell을 만들어서 이미지를 넣는 방식
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.textLabel?.text = "〰️👋🏻 \(menu[indexPath.row])"
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
            //dequeue: que라는 자료구조에서 재사용 cell 데이터를 끄집어내는 것
            cell.setImageName(name: menu[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // let cell: menuCell = tableView.cellForRow(at: indexPath) as! menuCell
        return 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name: String = menu[indexPath.row]
        let alert = UIAlertController(title: "확인🙃👀", message: "\(name)가 선택되었습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}
    
//    // Header - 섹션의 Header에는 얘를 들면 ㄱ,ㄴ,ㄷ 같은 것들을 넣을 수 있음.
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return UITableView
//    }
//
//
//    // 밀어서 삭제하기
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        <#code#>
//    }
//
//
//      Facebook 처럼 요런 방식으로도 가능함
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if contentSize.offset.y < 100 {
//            data 추가 요청
//        }
//    }
