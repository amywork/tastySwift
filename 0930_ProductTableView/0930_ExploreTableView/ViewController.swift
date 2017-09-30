//
//  ViewController.swift
//  0930_ExploreTableView
//
//  Created by Kimkeeyun on 30/09/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var gnbLogoLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        gnbLogoLabel = UILabel()
        gnbLogoLabel!.text = "Product Hunt"
        gnbLogoLabel!.font = UIFont.boldSystemFont(ofSize: 17)
        gnbLogoLabel!.textAlignment = .center
        gnbLogoLabel!.frame = CGRect(x: 0, y: 31, width: self.view.bounds.width, height: 22)
        self.view.addSubview(gnbLogoLabel!)
        
        let productExploreTable: UITableView = UITableView(frame: CGRect(x: 0, y: 64, width: view.frame.size.width, height: view.frame.size.height-64), style: .grouped)
        productExploreTable.delegate = self
        productExploreTable.dataSource = self
        productExploreTable.register(ExploreCell.self, forCellReuseIdentifier: "ExploreCell")
        view.addSubview(productExploreTable)
    }

    let indexColor: [UIColor] = [#colorLiteral(red: 1, green: 0, blue: 0.3098409176, alpha: 1), #colorLiteral(red: 1, green: 0.5630813837, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 0.4710169435, blue: 1, alpha: 1), #colorLiteral(red: 0, green: 0.8702064157, blue: 0.319252789, alpha: 1), #colorLiteral(red: 1, green: 0.2641522884, blue: 0.8162153959, alpha: 1)]
    let imgList: [String] = ["drone","camera","dica","glasses","audio"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return indexColor.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "☞ picked by @younari.me"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productCell = tableView.dequeueReusableCell(withIdentifier: "ExploreCell", for: indexPath) as! ExploreCell
        productCell.setImgName(name: imgList[indexPath.row])
        productCell.itemDecoView?.backgroundColor = indexColor[indexPath.row]
        
        return productCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let okAlert: UIAlertController = UIAlertController(title: "🙃", message: "\(indexPath.row)를 구매하시겠습니까?", preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        okAlert.addAction(okAction)
        self.present(okAlert, animated: true, completion: nil)
    }
}

