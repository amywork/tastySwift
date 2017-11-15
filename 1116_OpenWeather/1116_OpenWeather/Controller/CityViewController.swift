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
    
    private var todayWeather: TodayWeather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchToday(string: CityURL.copenhagen.rawValue)
        fetchToday(string: CityURL.melbourne.rawValue)
        fetchToday(string: CityURL.portland.rawValue)
    }

    func fetchToday(string: String) {
        var request = URLRequest(url: URL(string: string)!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let mainDic = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, AnyObject>
                    self.todayWeather = TodayWeather(dic: mainDic)
                    DispatchQueue.main.async {
                        self.updateUI()
                    }
                } catch let err {
                    print("\(err.localizedDescription)")
                }
            }
            }.resume()
    }

    func updateUI() {
        let temp: String = todayWeather?.temp ?? ""
        let imgName: String = todayWeather?.weatherType ?? "Clear"
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
