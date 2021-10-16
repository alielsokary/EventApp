//
//  MKMapView+Extension.swift
//  EventApp
//
//  Created by Ali Elsokary on 16/10/2021.
//  
//

import MapKit

extension MKMapView {
  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 5000) {
	let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
	setRegion(coordinateRegion, animated: true)
  }
}
