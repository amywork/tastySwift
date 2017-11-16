//
//  CityViewController.swift
//  1116_URL
//
//  Created by Kimkeeyun on 15/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//
//  CityViewController (Tab 02)

import UIKit
class CityViewController: UIViewController {

    // MARK : - Outlet
    @IBOutlet weak var copenhagenTempLabel: UILabel!
    @IBOutlet weak var copenhagenImageView: UIImageView!
    @IBOutlet weak var melbourneTempLabel: UILabel!
    @IBOutlet weak var melbourneImageView: UIImageView!
    @IBOutlet weak var portlandTempLabel: UILabel!
    @IBOutlet weak var portlandImageView: UIImageView!
    
    private var copenhagenWeather: TodayWeather? {
        didSet {
            let temp: String = copenhagenWeather?.temp ?? ""
            let imgName: String = copenhagenWeather?.weatherType ?? "Clear"
            self.copenhagenTempLabel.text = "Today: \(temp)C"
            self.copenhagenImageView.image = UIImage(named: imgName)
        }
    }
    
    private var melbourneWeather: TodayWeather? {
        didSet {
            let temp: String = melbourneWeather?.temp ?? ""
            let imgName: String = melbourneWeather?.weatherType ?? "Clear"
            self.melbourneTempLabel.text = "Today: \(temp)C"
            self.melbourneImageView.image = UIImage(named: imgName)
        }
    }
    
    private var portlandWeather: TodayWeather? {
        didSet {
            let temp: String = portlandWeather?.temp ?? ""
            let imgName: String = portlandWeather?.weatherType ?? "Clear"
            self.portlandTempLabel.text = "Today: \(temp)C"
            self.portlandImageView.image = UIImage(named: imgName)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FetchAllCity()
    }

    private func FetchAllCity() {
        RequestManager.shared.fetchToday(string: CityURL.copenhagen.rawValue) { (success, err) in
            if success {
                DispatchQueue.main.async {
                    self.copenhagenWeather = WeatherData.shared.todayWeather
                }
            }else {
                print("error")
            }
        }
        RequestManager.shared.fetchToday(string: CityURL.melbourne.rawValue) { (success, err) in
            if success {
                DispatchQueue.main.async {
                    self.melbourneWeather = WeatherData.shared.todayWeather
                }
            }else {
                print("error")
            }
        }
        RequestManager.shared.fetchToday(string: CityURL.portland.rawValue) { (success, err) in
            if success {
                DispatchQueue.main.async {
                    self.portlandWeather = WeatherData.shared.todayWeather
                }
            }else {
                print("error")
            }
        }
    }
    
}
