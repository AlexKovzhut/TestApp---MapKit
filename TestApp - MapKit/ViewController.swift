//
//  ViewController.swift
//  TestApp - MapKit
//
//  Created by Alexander Kovzhut on 09.10.2021.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    //Создаем карту
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false //Чтобы autolayout не транслировал автоизменение размера(autoresizing masks) в констрейнты
        return mapView
    } ()
    
    //Создаем кнопки
    let addAdressButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Add", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.systemOrange
        button.tintColor = UIColor.white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        return button
    }()
    
    let routeAdressButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Route", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.backgroundColor = UIColor.systemOrange
        button.tintColor = UIColor.white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
                
        return button
    }()
    
    let clearAdressButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Clear", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.backgroundColor = UIColor.systemOrange
        button.tintColor = UIColor.white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        return button
    }()
    
    //Пустой массив аннотаций-пинов
    var annotationsArray = [MKPointAnnotation]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        setConstraints()
        
        addAdressButton.addTarget(self, action: #selector(addAdressButtonTapped), for: .touchUpInside)
        routeAdressButton.addTarget(self, action: #selector(routeAdressButtonTapped), for: .touchUpInside)
        clearAdressButton.addTarget(self, action: #selector(clearAdressButtonTapped), for: .touchUpInside)
    }
    
    @objc func addAdressButtonTapped() {
        
        //Алерт нажатие на кнопку Add
        alertAddAdress(title: "Add address", placeholder: "Enter address") { [weak self] (text) in
            self?.setupPlacemark(addressPlace: text)
        }
    }
    
    @objc func routeAdressButtonTapped() {
        
        //Цикл для вызова метода createRouteRequest по точкам
        for index in 0...annotationsArray.count - 2 {
            createRouteRequest(startCoordinate: annotationsArray[index].coordinate, destinationCoordinate: annotationsArray[index + 1].coordinate)
        }
        
        mapView.showAnnotations(annotationsArray, animated: true)
    }
    
    @objc func clearAdressButtonTapped() {
        //Удаляем overlays, annotations, делаем массив пустым, прячем кнопки
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        
        annotationsArray = [MKPointAnnotation]()
        
        routeAdressButton.isHidden = true
        clearAdressButton.isHidden = true
    }
    
    private func setupPlacemark(addressPlace: String) {
        
        //Создаем и добавляем пин
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressPlace) { [weak self] (placemarks, error) in
            if let error = error {
                print(error)
                self?.alertError(title: "Error!", message: "Please, add the address again")
                return
            }
            
            guard let placemarks = placemarks else { return }
            let placemark = placemarks.first
            
            let annotation = MKPointAnnotation()
            annotation.title = "\(addressPlace)"
            
            guard let placemarkLocation = placemark?.location else { return }
            annotation.coordinate = placemarkLocation.coordinate
            
            self?.annotationsArray.append(annotation)
            
            if (self?.annotationsArray.count)! > 1 {
                self?.routeAdressButton.isHidden = false
                self?.clearAdressButton.isHidden = false
            }
            
            self?.mapView.showAnnotations((self?.annotationsArray)!, animated: true)
        }
    }
    
    //Построение маршрута между пинами
    private func createRouteRequest(startCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
        let startLocation = MKPlacemark(coordinate: startCoordinate)
        let destinationLocation = MKPlacemark(coordinate: destinationCoordinate)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startLocation)
        request.destination = MKMapItem(placemark: destinationLocation)
        request.transportType = MKDirectionsTransportType.automobile //Метод перемещения по карте - авто
        request.requestsAlternateRoutes = true
        
        let direction = MKDirections(request: request)
        direction.calculate { (responce, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let responce = responce else {
                self.alertError(title: "Error!", message: "This route is not available")
                return
            }
            
            var shortRoute = responce.routes[0]
            for route in responce.routes { //Вычисляем самый короткий маршрут
                shortRoute = (route.distance < shortRoute.distance) ? route : shortRoute
            }
            
            self.mapView.addOverlay(shortRoute.polyline)
        }
    }
}

extension ViewController: MKMapViewDelegate {
    //Отображение polyline
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .systemOrange
        
        return renderer
    }
}

extension ViewController {
    
    //Распологаем элементы на view и присваиваем ограничения
    func setConstraints() {
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
        
        mapView.addSubview(addAdressButton)
        NSLayoutConstraint.activate([
            addAdressButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 50),
            addAdressButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -15),
            addAdressButton.heightAnchor.constraint(equalToConstant: 40),
            addAdressButton.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        mapView.addSubview(routeAdressButton)
        NSLayoutConstraint.activate([
            routeAdressButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 120),
            routeAdressButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -15),
            routeAdressButton.heightAnchor.constraint(equalToConstant: 40),
            routeAdressButton.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        mapView.addSubview(clearAdressButton)
        NSLayoutConstraint.activate([
            clearAdressButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 190),
            clearAdressButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -15),
            clearAdressButton.heightAnchor.constraint(equalToConstant: 40),
            clearAdressButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}
