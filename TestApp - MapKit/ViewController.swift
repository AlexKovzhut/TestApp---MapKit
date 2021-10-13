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
    
    var places: [Places] = []
    
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
    
    func loadInitalData() {
        guard let fileName = Bundle.main.url(forResource: "Places", withExtension: "Geojson"), let placesData = try? Data(contentsOf: fileName) else {
            return
        }
        
        do {
            let features = try MKGeoJSONDecoder() .decode(placesData).compactMap( $0 as? MKGeoJSONFeature)
            
            let validWorks = features.compactMap(Places.init)
            places.append(contentsOf: validWorks)
        } catch {
            print(error)
        }
    }
    
}

extension MKMapView {
    // метод определяющий локацию в радиусе 1 км
    func centerLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 500) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        setRegion(coordinateRegion, animated: true)
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Places else { return nil}
        
        let identifier = "place"
        let view: MKMarkerAnnotationView
        
        if let dequeuedView = MapView.dequeueReusableAnnotationView(withIdentifier: "place") as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let places = view.annotation as? Places else {
            return
        }
        
        let launchOption = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        
        places.mapItem?.openInMaps(launchOptions: launchOption)
    }
}
