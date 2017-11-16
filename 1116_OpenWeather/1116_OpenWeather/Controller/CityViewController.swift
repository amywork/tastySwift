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
    
    private var todayWeather: TodayWeather?

    override func viewDidLoad() {
        super.viewDidLoad()
        FetchAllCity()
    }

    private func FetchAllCity() {
        RequestManager.shared.fetchToday(string: CityURL.copenhagen.rawValue) { (success, data, err) in
            if success {
                self.todayWeather = WeatherData.shared.todayWeather
                DispatchQueue.main.async {
                    self.updateUI()
                }
            }else {
                print("error")
            }
        }
        RequestManager.shared.fetchToday(string: CityURL.melbourne.rawValue) { (success, data, err) in
            if success {
                self.todayWeather = WeatherData.shared.todayWeather
                DispatchQueue.main.async {
                    self.updateUI()
                }
            }else {
                print("error")
            }
        }
        RequestManager.shared.fetchToday(string: CityURL.portland.rawValue) { (success, data, err) in
            if success {
                self.todayWeather = WeatherData.shared.todayWeather
                DispatchQueue.main.async {
                    self.updateUI()
                }
            }else {
                print("error")
            }
        }
    }
    
    private func updateUI() {
        let temp: String = todayWeather?.temp ?? ""
        let imgName: String = todayWeather?.weatherType ?? "Clear"
        // 아래 스위치문으로 바꾸기
        if todayWeather?.cityName == "Copenhagen" {
            self.copenhagenTempLabel.text = "Today: \(temp)C"
            self.copenhagenImageView.image = UIImage(named: imgName)
        }else if todayWeather?.cityName == "Melbourne" {
            self.melbourneTempLabel.text = "Today: \(temp)C"
            self.melbourneImageView.image = UIImage(named: imgName)
        }else if todayWeather?.cityName == "Portland" {
            self.portlandTempLabel.text = "Today: \(temp)C"
            self.portlandImageView.image = UIImage(named: imgName)
        }
    }
}
