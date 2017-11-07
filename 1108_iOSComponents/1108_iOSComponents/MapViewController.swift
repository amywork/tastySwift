//
//  MapViewController.swift
//  1108_iOSComponents
//
//  Created by 김기윤 on 07/11/2017.
//  Copyright © 2017 younari. All rights reserved.
//
//  01. Region: 지역(MKCoordinateRegion)
//  02. Span: 펼쳐진 영역 (Zoon Level) - MKCoordinateSpan
//      -> 1 degree of latitude is 111 kilometers.
//  03. Location Coordinate (latitude: 가로 + longitude: 세로) = 맵뷰의 센터 좌표 (Float)

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userLocation: CLLocationCoordinate2D? = locationManager.location?.coordinate
        let region = MKCoordinateRegion(center: userLocation!, span: span)
        mapView.setRegion(region, animated: true)
    }

}
