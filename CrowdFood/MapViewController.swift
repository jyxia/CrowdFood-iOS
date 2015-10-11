//
//  MapViewController.swift
//  CrowdFood
//
//  Created by Jinyue Xia on 10/10/15.
//  Copyright © 2015 Jinyue Xia. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

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
    self.retrieveRestaurants()
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
  
  func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
    var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier("CustomizedPin") as? MKPinAnnotationView
    if pinView == nil {
      pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "CustomizedPin")
      pinView!.canShowCallout = true
      pinView!.leftCalloutAccessoryView = UIImageView(frame: CGRectMake(0, 0, 50, 50))
      pinView!.leftCalloutAccessoryView?.contentMode = UIViewContentMode.ScaleAspectFit
  
      if #available(iOS 9, *) {
        pinView!.pinTintColor = UIColor.greenColor()
      } else {
        pinView!.pinColor = .Green
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
  
  @IBAction func addReport(sender: UIBarButtonItem) {
    // self.performSegueWithIdentifier("AddReportSegue", sender: self)
    
    let alertController = UIAlertController(title: "Estimated Time", message: nil, preferredStyle: .ActionSheet)
    let levelOne = UIAlertAction(title: "Less than 5 minute", style: .Default, handler: { (action) -> Void in
    })
    let levelTwo = UIAlertAction(title: "Less than 10 minute", style: .Default, handler: { (action) -> Void in
    })
    let levelThree = UIAlertAction(title: "More than 15 minute", style: .Default, handler: { (action) -> Void in
    })
    let delete = UIAlertAction(title: "Add a photo", style: .Destructive) { (action) -> Void in
    }
    let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action) -> Void in
    })
    
    alertController.addAction(levelOne)
    alertController.addAction(levelTwo)
    alertController.addAction(levelThree)
    alertController.addAction(cancel)
    alertController.addAction(delete)
    
    presentViewController(alertController, animated: true, completion: nil)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "AddReportSegue" {
      self.navigationController?.setToolbarHidden(true, animated: true)
      self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    if segue.identifier == "MapToReports" {
      self.navigationController?.setNavigationBarHidden(false, animated: true)
      if let destVC = segue.destinationViewController as? ReportsTableViewController {
        destVC.reports = []
      }
    }
  }
  
  func retrieveRestaurants() {
    let api = API()
    let apiURL = api.getListRestaurantsAPI()
    
    Alamofire.request(.GET, apiURL)
      .responseJSON {
        response in
        if let json = response.result.value {
          let data = json["data"] as! NSArray
          for restaurant in data {
            let newRestaurant = Restaurant()
            let id = restaurant["_id"] as! String
            newRestaurant.id = id
            let attributes = restaurant["attribute"] as! NSDictionary
            newRestaurant.name = attributes["name"] as! String
            newRestaurant.waiting = attributes["waiting"] as! Int
            let location = attributes["loc"] as! NSDictionary
            let coordinates = location["coordinates"] as! NSArray
            let latitude = coordinates[0] as! Double
            let longitude = coordinates[1] as! Double
            let geoLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            newRestaurant.coordinates = geoLocation
            print(newRestaurant.toString())
          }
        }
    }
  }
  
}

