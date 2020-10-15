//
//  Mypin.swift
//  FinalProject
//
//  Created by Abcd on 10/7/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import MapKit

class MyPin: NSObject, MKAnnotation {
    let id: Int
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(id: Int, title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
