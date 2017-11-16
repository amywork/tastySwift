//  WeatherViewController.swift
//  1116_URL
//
//  Created by 김기윤 on 15/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//
//  WeatherViewController (Tab 01)

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {

    // MARK : - Outlet
    @IBOutlet weak var todayTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK : - Data property
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        currentLocation = locations.last!
        Location.shared.latitude = currentLocation?.coordinate.latitude
        Location.shared.longitude = currentLocation?.coordinate.longitude
        
        RequestManager.shared.fetchToday(string: locationURL, completion: { [unowned self] (isSucess, data, err) in
            if isSucess {
                self.todayWeather = WeatherData.shared.todayWeather
                DispatchQueue.main.async {
                    self.updateUI()
                }
            }else {
                if let err = err {
                    print(err.localizedDescription)
                }
            }
        })
        
        RequestManager.shared.fetchForecast(string: locationForecastURL, completion: { [unowned self] (isSucess, err) in
            if isSucess {
                self.forecasts = WeatherData.shared.forecasts
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }else {
                if let err = err {
                    print(err.localizedDescription)
                }
            }
        })
    }
    
    private func updateUI() {
        if let temp = todayWeather?.temp {
            todayTempLabel.text = "오늘의 평균 기온: \(temp)C"
        }
        locationLabel.text = todayWeather?.cityName
        currentWeatherImageView.image = UIImage(named: "\(todayWeather?.weatherType ?? "NoImage")")
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
