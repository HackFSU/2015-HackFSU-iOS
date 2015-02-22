//
//  MapsViewController.swift
//  HackFSU
//
//  Created by Trevor Helms on 2/21/15.
//  Copyright (c) 2015 HackFSU. All rights reserved.
//

import UIKit
import MapKit

class MapsViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    let VenueCoordinates = (latitude: 30.445182, longitude: -84.299891)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let location = CLLocationCoordinate2D(latitude: VenueCoordinates.latitude, longitude: VenueCoordinates.longitude)
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.setCoordinate(location)
        annotation.title = "HackFSU"
        annotation.subtitle = "Dirac Science Library"
        mapView.addAnnotation(annotation)
    }
    
}
