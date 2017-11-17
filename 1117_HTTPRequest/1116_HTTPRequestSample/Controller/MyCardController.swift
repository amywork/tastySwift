//
//  MainViewController.swift
//  1116_HTTPRequestSample
//
//  Created by 김기윤 on 16/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

class MyCardController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var cardList: [CardData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Token: \(NetworkManger.shared.token!)")

        // First Request
        requestPostData()
        
        NotificationCenter.default.addObserver(forName: Notification.Name.AddCardDataNotification, object: nil, queue: nil) { (noti) in
            // Request cardList
            self.requestPostData()
        }
    }
    
    private func requestPostData() {
        NetworkManger.shared.requestPosts { (isSucess, data, error) in
            if isSucess {
                print("뷰컨트롤러에서 데이터를 잘 받았습니다.")
                self.cardList = data as? [CardData]
                print("뷰컨트롤러에서 서버에서 받은 데이터를 리스트에 모두 넣었습니다.")
                DispatchQueue.main.async { [ weak self ] in
                    self?.tableView.reloadData()
                }
            }
        }
    }
    

}

// MARK : MyCardController -- TableView DataSource
extension MyCardController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Cards"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cardList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CustomCardCell
        cell.data = cardList![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
