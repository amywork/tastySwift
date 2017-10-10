//
//  ViewController.swift
//  1011_ViewController
//
//  Created by 김기윤 on 10/10/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tableView: UITableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self // UITableViewDataSource 선언
        tableView.delegate = self // UITableViewDelegate 선언
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = "👋🏻"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // let cell: menuCell = tableView.cellForRow(at: indexPath) as! menuCell
        return 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // cell 클릭 후
        // 스토리보드를 통해 UI를 만들어놓은 ViewController의 인스턴스를 생성하여 present
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController
        present(secondVC!, animated: true, completion: nil)
    }
    
}


