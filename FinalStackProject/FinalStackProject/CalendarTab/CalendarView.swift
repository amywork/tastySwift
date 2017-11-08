//
//  CalendarView.swift
//
//  Created by 김기윤 on 08/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import Foundation
import UIKit

enum WeekDay: Int {
    case Sun=0,Mon,Tue,Wed,Thu,Fri,Sat
    var name: String {
        switch self {
        case .Sun:
            return "S"
        case .Mon:
            return "M"
        case .Tue:
            return "T"
        case .Wed:
            return "W"
        case .Thu:
            return "T"
        case .Fri:
            return "F"
        case .Sat:
            return "S"
        }
    }
}

// MARK : - CalendarDataModel
struct CalendarDataModel {
    
    var year: Int
    var month: Int
    var day: Int
    
    var startWeekDayOfMonth: WeekDay
    var lastDayOfMonth: Int
    
    private let calendar = Calendar(identifier: .gregorian)
    // Locale, Timezone : default == device default
    
    init?(date: Date) {
        var components = calendar.dateComponents([.year,.month,.day], from: date)
        self.year = components.year ?? 0
        self.month = components.month ?? 0
        self.day = components.day ?? 0
        components.day = 1
        
        guard let firstDateOfMonth = calendar.date(from: components) else { return nil }
        var weekDayCompo = calendar.dateComponents([.weekday], from: firstDateOfMonth)
        let weekDate = weekDayCompo.weekday ?? 1
        startWeekDayOfMonth = WeekDay.init(rawValue: weekDate - 1)!
        
        var addComponents = DateComponents()
        addComponents.month = 1
        addComponents.day = -1
        guard let lastDate = calendar.date(byAdding: addComponents, to: firstDateOfMonth) else { return nil }
        let lastday = calendar.dateComponents([.day], from: lastDate).day ?? 30
        lastDayOfMonth = lastday
    }
    
    func newDate(of day: Int) -> Date {
        var components = DateComponents()
        components.year = self.year
        components.month = self.month
        components.day = day
        return calendar.date(from: components)!
    }
}

// MARK : - CalendarManager
class CalendarManager {
    
    class func nextMonth(with currentDate:Date) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year,.month], from: currentDate)
        let date = calendar.date(from: components)!
        var addCompo = DateComponents()
        addCompo.month = 1
        guard let newDate = calendar.date(byAdding: addCompo, to: date) else { return nil }
        return newDate
    }
    
    class func prevMonth(with currentDate:Date) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year,.month], from: currentDate)
        let date = calendar.date(from: components)!
        var addCompo = DateComponents()
        addCompo.month = -1
        guard let newDate = calendar.date(byAdding: addCompo, to: date) else { return nil }
        return newDate
    }
    
}

// MARK : - CalendarView
@objc protocol CalendarViewDelegate {
    @objc optional func calendar(_ calendar: CalendarView, didSelectedDate: Date)
}

class CalendarView: UIView, CalendarViewDelegate {
    
    var year: Int?
    var month: Int?
    var delegate: CalendarViewDelegate?
    private var calendarDateModel: CalendarDataModel?
    var date: Date? {
        willSet {
            calendarDateModel = CalendarDataModel(date: newValue!)
            year = calendarDateModel?.year
            month = calendarDateModel?.month
            contentView.reloadData()
        }
    }
    
    private let identifier: String = "CustomDateCell"
    private var contentView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        return collectionView
    }()
    
    // MARK : - init
    override func awakeFromNib() {
        updateUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

// MARK : - CalendarView CollectionView
extension CalendarView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private func updateUI() {
        self.addSubview(contentView)
        contentView.delegate = self
        contentView.dataSource = self
        contentView.register(CustomDateCell.self, forCellWithReuseIdentifier: identifier)
        updateLayout()
    }
    
    // CollectionView의 Autolayout
    private func updateLayout() {
        contentView.autolayout(targetView: self, topConstant: 0, rightConstant: 0, bottomConstant: 0, leftConstant: 0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 7
        }else if section == 1 {
            if let manager = calendarDateModel {
                return manager.lastDayOfMonth + manager.startWeekDayOfMonth.rawValue
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CustomDateCell
        cell.clearCell()
        
        if indexPath.section == 0 {
            cell.dateLabel.text = WeekDay(rawValue: indexPath.row)?.name
            cell.dateLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            cell.dateLabel.textColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
            cell.isUserInteractionEnabled = false
        }else if indexPath.section == 1 {
            cell.dateLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            cell.dateLabel.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            let changedIndex = indexPath.row - calendarDateModel!.startWeekDayOfMonth.rawValue
            let day = changedIndex+1
            if changedIndex >= 0 {
                cell.dateLabel.text = "\(day)"
                cell.date = calendarDateModel!.newDate(of: day)
            }
            
            if day == calendarDateModel!.day {
                cell.highlight()
            }
            
            if day == calendarDateModel!.day + 12 {
                // 유저가 등록한 날짜일 경우
                cell.higlightRed()
            }
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    /*sizeForItemAt*/
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width/7
        if indexPath.section == 0 {
            return CGSize(width: width, height: collectionView.bounds.height/7)
        }else {
            return CGSize(width: width, height: width)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 해당 cell의 컬러 바꿔주고
        let cell = collectionView.cellForItem(at: indexPath) as! CustomDateCell
        cell.dateLabel.textColor = #colorLiteral(red: 0, green: 0.4823529412, blue: 1, alpha: 1)
        // 해당 cell에 해당하는 stack data를 테이블뷰에 로드함
        delegate?.calendar!(self, didSelectedDate: cell.date!)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CustomDateCell
        cell.dateLabel.textColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
    }
    
}

extension CalendarView {
    
    func updateNextMonth() {
        date = CalendarManager.nextMonth(with: date!)
    }
    
    func updatePrevMonth() {
        date = CalendarManager.prevMonth(with: date!)
    }
    
}

// CollectionView CustomCell
class CustomDateCell: UICollectionViewCell {
    
    var date: Date?
    var cellWidth: CGFloat {
        return self.bounds.size.width
    }
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    // view hidden or show
    var redBadge: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.2879420339, alpha: 1)
        return view
    }()
    
    private func updateUI() {
        redBadge.frame = CGRect(x: cellWidth - 15, y: 5, width: 10, height: 10)
        redBadge.layer.cornerRadius = redBadge.frame.size.width/2
        self.addSubview(redBadge)
        self.addSubview(dateLabel)
    }
    
    func highlight() {
        self.backgroundColor = #colorLiteral(red: 1, green: 0.9404012561, blue: 0.01922963001, alpha: 1)
        self.layer.cornerRadius = self.frame.size.width/2
    }
    
    func higlightRed() {
        redBadge.isHidden = false
    }
    
    func clearCell() {
        self.backgroundColor = .clear
        redBadge.isHidden = true
        dateLabel.text = ""
        date = nil
    }
    
    // dateLabel의 cell에 대한 Autolayout
    private func updateLayout() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        dateLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        dateLabel.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateUI()
        updateLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}



// AutoLayout
extension UIView {
    
    func autolayout(targetView: UIView, topConstant: CGFloat?, rightConstant: CGFloat?, bottomConstant: CGFloat?, leftConstant: CGFloat?) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let constant = topConstant{
            self.topAnchor.constraint(equalTo: targetView.topAnchor, constant: constant).isActive = true
        }
        
        if let constant = rightConstant{
            self.rightAnchor.constraint(equalTo: targetView.rightAnchor, constant: constant).isActive = true
        }
        
        if let constant = bottomConstant{
            self.bottomAnchor.constraint(equalTo: targetView.bottomAnchor, constant: constant).isActive = true
        }
        
        if let constant = leftConstant{
            self.leftAnchor.constraint(equalTo: targetView.leftAnchor, constant: constant).isActive = true
        }
    }
    
    func autolayout(targetView: UIView, widthMultiplier: CGFloat?, heightMultiplier: CGFloat?) {
        
        if let multiplier = widthMultiplier {
            self.widthAnchor.constraint(equalTo: targetView.widthAnchor, multiplier: multiplier).isActive = true
        }
        
        if let multiplier = heightMultiplier {
            self.heightAnchor.constraint(equalTo: targetView.heightAnchor, multiplier: multiplier).isActive = true
        }
        
    }
    
}

