//
//  CalendarViewController.swift
//
//  Created by 김기윤 on 08/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class CalendarViewController: UIViewController, CalendarViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    //KEY: MM DD
    var stacks = ["1111":"Dropbox", "1112":"Dropbox", "1113":"Dropbox", "1114":"Dropbox", "1115":"Dropbox"]
    
    func calendar(_ calendar: CalendarView, didSelectedDate: Date) {
        //didSelectedDate와 매칭하는 값만 테이블뷰 리로드
        let newList = stacks.filter({ (key,value) in
            key == didSelectedDate.mmdd
        })
        stacks = newList
        tableView.reloadData()
    }
    
    /*Calendar*/
    @IBOutlet weak var calendarView: CalendarView!
    @IBOutlet weak var thisMonthLabel: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.delegate = self
        calendarView.date = Date()
        thisMonthLabel.title = "\(calendarView.year ?? 1). \(calendarView.month ?? 1)"
    }
    
    @IBAction func toNextMonth(_ sender: UIButton) {
        calendarView.updateNextMonth()
        thisMonthLabel.title = "\(calendarView.year ?? 1). \(calendarView.month ?? 1)"
    }
    @IBAction func toPrevMonth(_ sender: UIButton) {
        calendarView.updatePrevMonth()
        thisMonthLabel.title = "\(calendarView.year ?? 1). \(calendarView.month ?? 1)"
    }
    
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stacks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Dropbox"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Upcomings"
    }
}


extension Date {
    
    var mmdd:String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "MMdd"
        return dateFormatter.string(from: self)
    }
    
}


