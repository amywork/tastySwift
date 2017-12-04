//
//  ViewController.swift
//  171115_Network
//
//  Created by SIMA on 2017. 11. 15..
//  Copyright © 2017년 SimaDev. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    

    @IBOutlet weak var cityNameLb: UILabel!
    @IBOutlet weak var currentWeatherLb: UILabel!
    @IBOutlet weak var minimumTempLb: UILabel!
    @IBOutlet weak var maximumTempLb: UILabel!
    @IBOutlet weak var weatherImgView: UIImageView!
    
    var weatherDatas: WeatherData?
    var tempDatas: TempData?
    var cityName: String = "Seoul"
    
    lazy var locationManager = CLLocationManager()
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather"
    let APIKey = "89e4a79cf2b99a9f6ac5d5654d83a51b"
    var fullURL = "http://api.openweathermap.org/data/2.5/weather?q=Seoul&APPID=89e4a79cf2b99a9f6ac5d5654d83a51b"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullURL = weatherURL + "?q=" + cityName + "&APPID=" + APIKey
        print("fullURL", fullURL)
        let url = URL(string: fullURL)
        print("url", url)
            var request = URLRequest(url: url!)
            request.httpMethod = "GET"
        
        let session = URLSession.shared
        DispatchQueue.global().async {
            session.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        //JSON 불러오기
                        let dataDic = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        //도시값 가져오기
                        self.cityName = dataDic["name"] as! String
                        //weather 정보 가져오기
                        guard let weatherId = dataDic["weather"] as? [[String: Any]] else { return }
                        self.weatherDatas = WeatherData(weatherDic: weatherId[0])
                        //temperature 정보 가져오기
                        guard let tempDic = dataDic["main"] as? [String: Any] else { return }
                        self.tempDatas = TempData(tempDic: tempDic)
                        DispatchQueue.main.async {
                            self.maximumTempLb.text = "  \(round(self.tempDatas!.maxTemp)) ˚"
                            self.minimumTempLb.text = "  \(round(self.tempDatas!.minTemp)) ˚"
                            self.currentWeatherLb.text = "  \(round(self.tempDatas!.temp)) ˚"
                            
                            self.weatherImgView.image = UIImage(named: self.weatherDatas!.weather)
                            self.cityNameLb.text = self.cityName
                        }
                       
                    }catch let error {
                        print(error.localizedDescription)
                    }
                }
                }.resume()

        }
        //        request.addValue("Token 173b78e9e0a0553f45fee10f2abf459a118a29a3", forHTTPHeaderField: "Authorization")
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        
            
            
    }
    
    @IBAction func citySearchButton(_ sender: UIButton) {
        
    }

}



