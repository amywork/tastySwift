	//
//  WeatherViewController.swift
//  1116_URL
//
//  Created by 김기윤 on 15/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {

    // MARK : - Outlet
    @IBOutlet weak var todayTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK : - Data property (request를 통해 얻어올 정보)
    private var forecasts: [Forecast] = []
    private var todayWeather: TodayWeather?
    
    // MARK : - Location
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    
    // MARK : - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        requestWhenInUseAuth()
    }
    
    private func requestWhenInUseAuth() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.shared.latitude = currentLocation?.coordinate.latitude
            Location.shared.longitude = currentLocation?.coordinate.longitude
            fetchToday(string: locationURL)
            fetchForecast(string: locationForecastURL)
        } else {
            locationManager.requestWhenInUseAuthorization()
            requestWhenInUseAuth()
        }
    }

}

/*Request Data*/
extension WeatherViewController {

    private func fetchForecast(string: String) {
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
                            if let forecast = Forecast(weatherDict: dic) {
                                self.forecasts.append(forecast)
                            }
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
    
    private func fetchToday(string: String) {
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
    
    private func updateUI() {
        if let temp = todayWeather?.temp {
            todayTempLabel.text = "오늘의 평균 기온: \(temp)C"
        }
        locationLabel.text = todayWeather?.cityName
        currentWeatherImageView.image = UIImage(named: "\(todayWeather?.weatherType ?? "Clear")")
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
            cell.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "5days Forecasts"
    }
    
}
