# Using Weather Map API

- [open weather map API home](http://openweathermap.org/api)
- pull weather data for free

## Call current weather data for one location
- [By city name](http://openweathermap.org/current)
- 회원가입 & API Key 받기 (ex.9eb78416466a2480d3da80192164b38c)

### Sample data
- [request url](http://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b1b15e88fa797225412429c1c50c122a1)

```
{"coord":{"lon":-0.13,"lat":51.51},"weather":[{"id":300,"main":"Drizzle","description":"light intensity drizzle","icon":"09d"}],"base":"stations","main":{"temp":280.32,"pressure":1012,"humidity":81,"temp_min":279.15,"temp_max":281.15},"visibility":10000,"wind":{"speed":4.1,"deg":80},"clouds":{"all":90},"dt":1485789600,"sys":{"type":1,"id":5091,"message":0.0103,"country":"GB","sunrise":1485762037,"sunset":1485794875},"id":2643743,"name":"London","cod":200}
```

## JSON formatter
- From the server call... We get dictionary & kord inside dic.
- [jsonformatter](http://jsonformatter.curiousconcept.com/)


# Get start

## By geographic coordinates
- **API call**: api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}
- **Parameters**: lat, lon coordinates of the location of your interest
- **Examples of API calls**: api.openweathermap.org/data/2.5/weather?lat=35&lon=139

## Constants.swift => just constants
```
let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "42a1771a0b787bf12e734ada0cfc80cb"
```

```
let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=42a1771a0b787bf12e734ada0cfc80cb"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&mode=json&appid=42a1771a0b787bf12e734ada0cfc80cb"
```

## CurrentWeather.swift => 
- server에게 현재 날씨 정보를 달라고 요청!

```
func downloadWeatherDetails(completed: @escaping DownloadComplete) {
    //Download Current Weather Data
    Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in
        let result = response.result
      
        if let dict = result.value as? Dictionary<String, AnyObject> {
            if let name = dict["name"] as? String {
                self._cityName = name.capitalized
                print(self._cityName)
            }
            
            if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                if let main = weather[0]["main"] as? String {
                    self._weatherType = main.capitalized
                    print(self._weatherType)
                }
            }
            
            if let main = dict["main"] as? Dictionary<String, AnyObject> {
                if let currentTemperature = main["temp"] as? Double {
                    let kelvinToFarenheitPreDivision = (currentTemperature * (9/5) - 459.67)
                    let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                    self._currentTemp = kelvinToFarenheit
                    print(self._currentTemp)
                }
            }
        }
        completed()
    }
}
```

## Location.swift => Singleton
- CoreLocation : import CoreLocation

```
var latitude: Double!
var longitude: Double!
```

## Forecast.swift


## WeatherVC.swift => View Controller
## WeatehrCell.swift => TableViewCell
