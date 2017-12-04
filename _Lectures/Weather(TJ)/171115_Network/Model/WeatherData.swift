
import Foundation


struct WeatherData {
    var weather: String
    
    init?(weatherDic: [String: Any]){
        guard let id = weatherDic["id"] as? Int else { return nil }
        switch (id) {
        case 0..<300 :
            self.weather = "Thunder"
        case 300..<500 :
            self.weather = "Drizzle"
        case 500..<600 :
            self.weather = "Rainy"
        case 600..<700 :
            self.weather = "Snowing"
        case 700..<800 :
            self.weather = "Windy"
        case 800..<900 :
            self.weather = "Cloudy"
        default:
            self.weather = "dunno"
        }
    }
}

struct TempData {
    var temp: Float
    var maxTemp: Float
    var minTemp: Float
    
    init?(tempDic: [String: Any]){
        guard let temp = tempDic["temp"] as? Float else { return nil }
        self.temp = (temp - 273)
        guard let maxTemp = tempDic["temp_max"] as? Float else { return nil }
        self.maxTemp = (maxTemp - 273)
        guard let minTemp = tempDic["temp_min"] as? Float else { return nil }
        self.minTemp = (minTemp - 273)
    }
}

struct CityData {
    var city: String
    var id: Int
    var country: String
    
    init?(cityDic: [String: Any]) {
        guard let city = cityDic["name"] as? String else { return nil }
        self.city = city
        guard let id = cityDic["id"] as? Int else { return nil }
        self.id = id
        guard let country = cityDic["country"] as? String else { return nil }
        self.country = country
    }
}
