//
//  MapViewController.swift
//  1108_iOSComponents
//
//  Created by 김기윤 on 07/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//
//  01. Region: 지역(MKCoordinateRegion)
//  02. Span: 펼쳐진 영역 (Zoom Level) - MKCoordinateSpan
//      -> 1 degree of latitude is 111 kilometers.
//  03. Location Coordinate (latitude: 가로 + longitude: 세로) = 맵뷰의 센터 좌표 (Float)


import UIKit
import MapKit
import CoreLocation

/*MKAnnotation: Data contains location information*/
class customAnnotation: NSObject, MKAnnotation {
    
    // protocol
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
    
}

class MapViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var annotations: [customAnnotation] = []
    var locationBookmarks: [BookMarkModel] = []
    
    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var currentCenter: CLLocationCoordinate2D? {
        return currentLocation?.coordinate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManagerUpdate()
        updateMapView()
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleTap(gestureReconizer:)))
        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func handleTap(gestureReconizer: UILongPressGestureRecognizer) {
        
        let location = gestureReconizer.location(in: mapView)
        let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
        // Add annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }

}

extension MapViewController: MKMapViewDelegate {
    
    func makeSampleBookmarks() {
        let starbucks1Location = CLLocationCoordinate2D(latitude: 37.658240, longitude: 126.794444)
        let starbucks2Location = CLLocationCoordinate2D(latitude: 37.658066, longitude: 126.793204)
        let starbucks1 = BookMarkModel(name: "starbucks1", locationCoordinate: starbucks1Location)
        let starbucks2 = BookMarkModel(name: "starbucks2", locationCoordinate: starbucks2Location)
        locationBookmarks.append(starbucks1)
        locationBookmarks.append(starbucks2)
    }
    
    func makeAnnotations() {
        makeSampleBookmarks()
        locationBookmarks.forEach { [weak self] (bookmark) in
            let annotation = customAnnotation(title: "\(bookmark.name)", coordinate: bookmark.locationCoordinate)
            self?.annotations.append(annotation)
        }
    }
    
    func updateMapView() {
        makeAnnotations()
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.addAnnotations(annotations)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? customAnnotation {
            let identity = "pin"
            var pinView: MKPinAnnotationView
            // 얘는 dequeue 없으면 nil이기 때문에 else 하고 새로 만드는 코드 넣어줌
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identity) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                dequeuedView.canShowCallout = true
                dequeuedView.calloutOffset = CGPoint(x: 0, y: 0)
                dequeuedView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
                pinView = dequeuedView
            }else {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identity)
                pinView.canShowCallout = true
                pinView.calloutOffset = CGPoint(x: -5, y: 5)
                pinView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            }
            return pinView
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // 클릭 되었을 때 화면을 전환하거나 북마크에 추가하는 등
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
   
    func locationManagerUpdate() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    /*--CLLocationManagerDelegate: didUpdateLocations--*/
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last
        {
            Location.sharedInstance.latitude = location.coordinate.latitude
            Location.sharedInstance.longitude = location.coordinate.longitude
            Location.sharedInstance.currentLocation = location.coordinate
            let currentPoint = Location.sharedInstance.currentLocation
            let region = MKCoordinateRegion(center: currentPoint!, span: span)
            mapView.setRegion(region, animated: true)
            locationManager.stopUpdatingLocation()
        }
    }
    
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation?.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation?.coordinate.longitude
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
}





