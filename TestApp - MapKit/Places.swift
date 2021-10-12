//
//  Places.swift
//  TestApp - MapKit
//
//  Created by Alexander Kovzhut on 10.10.2021.
//

import Foundation
import MapKit
import <#module#>

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
    
    var subtitle: String? {
        return locationName
    }
}
