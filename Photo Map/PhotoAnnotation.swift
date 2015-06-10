//
//  PhotoAnnotation.swift
//  Photo Map
//
//  Created by Alexander Hoekje List on 6/10/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class PhotoAnnotation: NSObject, MKAnnotation {
    @objc var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var photo: UIImage!
    
    var title: String! {
        return "\(coordinate.latitude)"
    }
}
