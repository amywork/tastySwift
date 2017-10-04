//
//  ViewController.swift
//  1003_DailyTable
//
//  Created by Kimkeeyun on 03/10/2017.
//  Copyright © 2017 yunari.me. All rights reserved.
//

import UIKit

class DateTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var days = [DateModel]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleData()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView) 
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DateTableViewCell") as! DateTableViewCell
        let date = days[indexPath.row]
        
        cell.colorBlock?.backgroundColor = date.color
        cell.titleLabel?.text = date.title
        cell.detailLabel?.text = date.detail
        
        return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    private func loadSampleData() {
        
        guard let date1 = DateModel(title: "heathceramics", detail: "@playmountaineast is showing he work of GO Koyama in the Boiler Room at Heath until October 22nd. Don't miss it!", color: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)) else {
            fatalError("Unable to instantiate")
        }
        
        guard let date2 = DateModel(title: "heathceramics", detail: "@playmountaineast is showing he work of GO Koyama in the Boiler Room at Heath until October 22nd. Don't miss it!", color: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)) else {
            fatalError("Unable to instantiate")
        }
        
        guard let date3 = DateModel(title: "heathceramics", detail: "@playmountaineast is showing he work of GO Koyama in the Boiler Room at Heath until October 22nd. Don't miss it!", color: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)) else {
            fatalError("Unable to instantiate")
        }
        
        guard let date4 = DateModel(title: "heathceramics", detail: "@playmountaineast is showing he work of GO Koyama in the Boiler Room at Heath until October 22nd. Don't miss it!", color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)) else {
            fatalError("Unable to instantiate")
        }
        
        days += [date1, date2, date3, date4]
        
    }
    
    
}

