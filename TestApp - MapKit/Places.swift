//
//  Places.swift
//  TestApp - MapKit
//
//  Created by Alexander Kovzhut on 10.10.2021.
//

import Foundation
import MapKit
import Contacts

class Places: NSObject, MKAnnotation {
    let title: String?
    let locationName: String?
    let category: String?
    let coordinate: CLLocationCoordinate2D
    
    init (title: String?, location: String?, category: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = location
        self.category = category
        self.coordinate = coordinate
        
        super.init()
    }
    
    init?(feature: MKGeoJSONFeature) {
        guard let point = feature.geometry.first as? MKPointAnnotation,
              let propertiesData = feature.properties,
              let json = try? JSONSerialization.jsonObject(with: propertiesData),
              let properties = json as? [String: Any]
              else {
            return nil
        }
        
        title = properties["title"] as? String
        locationName = properties["title"] as? String
        category = properties["title"] as? String
        coordinate = point.coordinate
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
    var mapItem: MKMapItem? {
        guard let location = locationName else {
            return nil
        }
        
        let addressDict = [CNPostalAddressStreetKey: location]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
}
