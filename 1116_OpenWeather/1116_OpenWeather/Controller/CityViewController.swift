//
//  CityViewController.swift
//  1116_URL
//
//  Created by Kimkeeyun on 15/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
class CityViewController: UIViewController {

    // MARK : - Outlet
    @IBOutlet weak var copenhagenTempLabel: UILabel!
    @IBOutlet weak var copenhagenImageView: UIImageView!
    @IBOutlet weak var melbourneTempLabel: UILabel!
    @IBOutlet weak var melbourneImageView: UIImageView!
    @IBOutlet weak var portlandTempLabel: UILabel!
    @IBOutlet weak var portlandImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RequestModel.shared.fetchToday(string: CityURL.copenhagen.rawValue) {
            self.updateUI()
        }
        RequestModel.shared.fetchToday(string: CityURL.portland.rawValue) {
            self.updateUI()
        }
        RequestModel.shared.fetchToday(string: CityURL.melbourne.rawValue) {
            self.updateUI()
        }
    }

    private func updateUI() {
        let temp: String = RequestModel.shared.todayWeather?.temp ?? ""
        let imgName: String = RequestModel.shared.todayWeather?.weatherType ?? "Clear"
        if RequestModel.shared.todayWeather?.cityName == "Copenhagen" {
            self.copenhagenTempLabel.text = "Today: \(temp)C"
            self.copenhagenImageView.image = UIImage(named: imgName)
        }else if RequestModel.shared.todayWeather?.cityName == "Melbourne" {
            self.melbourneTempLabel.text = "Today: \(temp)C"
            self.melbourneImageView.image = UIImage(named: imgName)
        }else if RequestModel.shared.todayWeather?.cityName == "Portland" {
            self.portlandTempLabel.text = "Today: \(temp)C"
            self.portlandImageView.image = UIImage(named: imgName)
        }
    }
}
