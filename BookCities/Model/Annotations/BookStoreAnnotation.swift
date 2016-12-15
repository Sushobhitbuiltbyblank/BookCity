//
//  BookStoreAnnotation.swift
//  BookMaps
//
//  Created by Sushobhit_BuiltByBlank on 11/21/16.
//  Copyright © 2016 Built by Blank India Pvt. Ltd. All rights reserved.
//

import UIKit
import MapKit

class BookStoreAnnotation: NSObject, MKAnnotation {
        
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var title: String?
    var subtitle: String?
    var imageName:String?
    var store:JSONStore?
    var tag:Int?
    class func createViewAnnotationForMapView(_ mapview: MKMapView, annotation: MKAnnotation) -> MKAnnotationView {
    var returnedAnnotationView =
    mapview.dequeueReusableAnnotationView(withIdentifier: String(describing: BookStoreAnnotation.self))
    if returnedAnnotationView == nil {
    returnedAnnotationView =
    MKAnnotationView(annotation: annotation, reuseIdentifier: String(describing: BookStoreAnnotation.self))
    
    returnedAnnotationView!.canShowCallout = true
    
    // offset the flag annotation so that the flag pole rests on the map coordinate
    returnedAnnotationView!.centerOffset = CGPoint(x: returnedAnnotationView!.centerOffset.x + (returnedAnnotationView!.image?.size.width ?? 0)/2, y: returnedAnnotationView!.centerOffset.y - (returnedAnnotationView!.image?.size.height ?? 0)/2)
    } else {
    returnedAnnotationView!.annotation = annotation
    }
    return returnedAnnotationView!
    }
}
