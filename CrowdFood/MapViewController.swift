//
//  MapViewController.swift
//  CrowdFood
//
//  Created by Jinyue Xia on 10/10/15.
//  Copyright © 2015 Jinyue Xia. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
  
  private let locationManager = CLLocationManager()
  
  @IBOutlet weak var cfMapView: MKMapView! {
    didSet {
      cfMapView.delegate = self
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.setNavigationBarHidden(true, animated: true)
    self.navigationController?.setToolbarHidden(false, animated: true)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.initLocationManager()
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  //------------------------------------------------------------------------------------------
  // LocationManager
  //------------------------------------------------------------------------------------------
  func initLocationManager() {
    self.locationManager.delegate = self
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    self.locationManager.requestAlwaysAuthorization()
    self.locationManager.startUpdatingLocation()
  }
  
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
    // Drop a pin
    let dropPin = MKPointAnnotation()
    dropPin.coordinate = location
    dropPin.title = "Jade Palace"
    dropPin.subtitle = "5 min waiting"
    cfMapView.removeAnnotations(cfMapView.annotations)
    cfMapView.addAnnotation(dropPin)
    //    cfMapView.showAnnotations(dropPin, animated: true)
    
  }
  
  //------------------------------------------------------------------------------------------
  // mapView delegates
  //------------------------------------------------------------------------------------------
  //  func mapView(mView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
  //    var customizedView = mView.dequeueReusableAnnotationViewWithIdentifier("CustomizedPin")
  //    if customizedView == nil {
  //      customizedView = MKAnnotationView(annotation: annotation, reuseIdentifier: "CustomizedPin")
  //      customizedView!.image = UIImage(named: "Timer-64")
  //      let priceLabel = UILabel(frame: CGRectMake(0, 0, 60, 40))
  //      priceLabel.textColor = UIColor.whiteColor()
  //      priceLabel.alpha = 0.8;
  //      priceLabel.tag = 42;
  //      customizedView!.addSubview(priceLabel)
  //      customizedView!.frame = priceLabel.frame
  //      customizedView!.canShowCallout = true
  //      customizedView!.leftCalloutAccessoryView = UIImageView(frame: CGRectMake(0, 0, 50, 50))
  //    } else {
  //      customizedView!.annotation = annotation
  //    }
  //
  //    let label = customizedView!.viewWithTag(42) as! UILabel
  //    label.textAlignment = .Center
  //    label.text = "100k+"
  //
  //    return customizedView
  //  }
  
  func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
    var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier("CustomizedPin")
    
    if pinView == nil {
      pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "CustomizedPin")
      pinView?.canShowCallout = true
      pinView!.leftCalloutAccessoryView = UIImageView(frame: CGRectMake(0, 0, 50, 50))
      pinView!.leftCalloutAccessoryView?.contentMode = UIViewContentMode.ScaleAspectFit
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
  
}

