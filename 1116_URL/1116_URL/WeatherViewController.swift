//
//  WeatherViewController.swift
//  1116_URL
//
//  Created by 김기윤 on 15/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
import Foundation

enum CityURL: String {
    case tokyo = "https://api.openweathermap.org/data/2.5/forecast?id=1850147&appid=9eb78416466a2480d3da80192164b38c"
    case copenhagen = "https://api.openweathermap.org/data/2.5/forecast?id=2618425&appid=9eb78416466a2480d3da80192164b38c"
    case seoul = "https://api.openweathermap.org/data/2.5/forecast?id=1835847&appid=9eb78416466a2480d3da80192164b38c"
}

class WeatherViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tokyoBtn: UIButton!
    // button 3개 추가, 버튼 클릭시 fetch data
    var forecasts: [Forecast] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        copenhagen()
    }
    
    @IBAction func tokyo() {
        fetchData(string: CityURL.tokyo.rawValue)
    }
    @IBAction func seoul() {
        fetchData(string: CityURL.seoul.rawValue)
    }
    @IBAction func copenhagen() {
        fetchData(string: CityURL.copenhagen.rawValue)
    }
    
    
    func fetchData(string: String) {
        var request = URLRequest(url: URL(string: string)!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let mainDic = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, AnyObject>
                    if let list = mainDic["list"] as? [Dictionary<String, AnyObject>] {
                        self.forecasts = []
                        for dic in list {
                            let forecast = Forecast(weatherDict: dic)
                            self.forecasts.append(forecast)
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                } catch let err {
                    print("\(err.localizedDescription)")
                }
            }
            }.resume()
    }

}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        let forecast = forecasts[indexPath.row]
        cell.configureCell(forecast: forecast)
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }else {
            cell.backgroundColor = #colorLiteral(red: 0.9117823243, green: 0.9118037224, blue: 0.9117922187, alpha: 1)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Forecasts"
    }
    
}
