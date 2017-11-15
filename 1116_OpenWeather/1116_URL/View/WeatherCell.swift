//
//  WeatherCell.swift
//  1116_URL
//
//  Created by 김기윤 on 15/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//

import UIKit

internal class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    @IBOutlet weak var weatherIconView: UIImageView!
    
    func configureCell(forecast: Forecast) {
        lowTempLabel.text = "\(forecast.lowTemp)"
        highTempLabel.text = "\(forecast.highTemp)"
        weatherTypeLabel.text = forecast.weatherType
        weatherIconView.image = UIImage(named: forecast.weatherType)
        dayLabel.text = forecast.date
    }
    
}
