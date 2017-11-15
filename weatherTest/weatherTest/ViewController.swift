//
//  ViewController.swift
//  weatherTest
//
//  Created by 김기윤 on 15/11/2017.
//  Copyright © 2017 younari. All rights reserved.
////
//  WeatherViewController.swift
//  1116_URL
//
//  Created by 김기윤 on 15/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit
import Foundation

enum CityURL: String {
    case tokyo = "api.openweathermap.org/data/2.5/forecast?id=1850147&appid=9eb78416466a2480d3da80192164b38c"
    case copenhagen = "api.openweathermap.org/data/2.5/forecast?id=2618425&appid=9eb78416466a2480d3da80192164b38c"
    case london = "api.openweathermap.org/data/2.5/forecast?id=2643743&appid=9eb78416466a2480d3da80192164b38c"
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData() {
        var request = URLRequest(url: URL(string: "api.openweathermap.org/data/2.5/weather?id=2172797&appid=9eb78416466a2480d3da80192164b38c")!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                print(data)
            }}.resume()
    }
    
}

