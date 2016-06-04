//
//  Mapview+delegates.swift
//  CrowdFood
//
//  Created by Jinyue Xia on 6/3/16.
//  Copyright © 2016 Jinyue Xia. All rights reserved.
//

import MapKit

extension MapViewController: MKMapViewDelegate {
  func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
    var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier("CustomizedPin") as? MKPinAnnotationView
    if pinView == nil {
      pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "CustomizedPin")
      pinView!.canShowCallout = true
      pinView!.leftCalloutAccessoryView = UIImageView(frame: CGRectMake(0, 0, 50, 50))
      pinView!.leftCalloutAccessoryView?.contentMode = UIViewContentMode.ScaleAspectFit
      
      if let rAnnotation = annotation as? RestaurantPointAnnotation {
        if rAnnotation.waiting <= 5 {
          pinView!.pinColor = .Green
        }
        
        if rAnnotation.waiting > 5 && rAnnotation.waiting < 10 {
          pinView!.pinColor = .Purple
        }
      }
      
      if annotation.isKindOfClass(MKUserLocation) {
        pinView?.canShowCallout = false
        return nil
      }
    } else {
      pinView!.annotation = annotation
    }
    
    return pinView
  }
  
  func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
    if let calloutImageView = view.leftCalloutAccessoryView as? UIImageView {
      calloutImageView.contentMode = UIViewContentMode.ScaleAspectFit
      calloutImageView.image = UIImage(named: "Future")
    }
    view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
  }
  
  func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    self.performSegueWithIdentifier("MapToReports", sender: view)
  }
}

extension MapViewController: CLLocationManagerDelegate {
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    self.locationManager.stopUpdatingLocation()
    let currentLocation = locations[0]
    let latitude: CLLocationDegrees = currentLocation.coordinate.latitude
    let longitude: CLLocationDegrees = currentLocation.coordinate.longitude
    let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
    let latDelta: CLLocationDegrees = 0.2
    let lonDelta: CLLocationDegrees = 0.2
    let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
    let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
    cfMapView.setRegion(region, animated: false)
    // cfMapView.showsUserLocation = true
  }
}