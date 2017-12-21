
# Core Location

## 준비
- `import CoreLocation`
- `var locationManager: CLLocationManager?`
- `CLLocationManagerDelegate`채택
- `info.plist` : Usage Description

## viewDidLoad
- `locationManager = CLLocationManager()`
- `locationManager?.desiredAccuracy = kCLLocationAccuracyBest`
- `locationManager?.delegate = self`

## Delegate Method

- `didChangeAuthorizationStatus`

```
func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
      locationManager?.startUpdatingLocation()
    }
  }
  
```

- `didUpdateLocations`

```
func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if startLocation == nil {
      startLocation = locations.first
    } else {
      // do something
    }
  }
  
```