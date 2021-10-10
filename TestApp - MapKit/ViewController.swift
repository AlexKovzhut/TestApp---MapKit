//
//  ViewController.swift
//  TestApp - MapKit
//
//  Created by Alexander Kovzhut on 09.10.2021.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var MapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 55.751244, longitude: 37.618423)
        
        MapView.centerLocation(initialLocation)
        
        let cameraCenter = CLLocation(latitude: 55.751244, longitude: 37.618423)
        let region = MKCoordinateRegion(center: cameraCenter.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        MapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        
        let zoomRage = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 25_000)
        MapView.setCameraZoomRange(zoomRage, animated: true)
        
        let place = Places(
            title: "Red Square",
            location: "Moscow",
            category: "Squares",
            coordinate: CLLocationCoordinate2D(
                latitude: 55.754093,
                longitude: 37.620407
            )
        )
        
        MapView.addAnnotation(place)
    }
}

extension MKMapView {
    // метод определяющий локацию в радиусе 1 км
    func centerLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 500) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        setRegion(coordinateRegion, animated: true)
    }
}

extension ViewController: MPKIt
