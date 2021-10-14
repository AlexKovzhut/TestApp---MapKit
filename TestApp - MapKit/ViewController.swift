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
        
        return button
    }()
    
    let routeAdressButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Route", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.backgroundColor = UIColor.systemOrange
        button.tintColor = UIColor.white
                
        return button
    }()
    
    let clearAdressButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Clear", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.backgroundColor = UIColor.systemOrange
        button.tintColor = UIColor.white
        
        return button
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        
        addAdressButton.addTarget(self, action: #selector(addAdressButtonTapped), for: .touchUpInside)
        routeAdressButton.addTarget(self, action: #selector(routeAdressButtonTapped), for: .touchUpInside)
        clearAdressButton.addTarget(self, action: #selector(clearAdressButtonTapped), for: .touchUpInside)
    }
    
    //Метод для отработки алерта добваления адреса
    @objc func addAdressButtonTapped() {
        alertAddAdress(title: "Add address", placeholder: "Enter address") { (text) in
            print(text)
        }
    }
    
    @objc func routeAdressButtonTapped() {
        
    }
    
    @objc func clearAdressButtonTapped() {
        
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
            addAdressButton.heightAnchor.constraint(equalToConstant: 50),
            addAdressButton.widthAnchor.constraint(equalToConstant: 70)
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
