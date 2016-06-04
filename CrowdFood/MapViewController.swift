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

class MapViewController: UIViewController {
  
  let locationManager = CLLocationManager()
  var restaurantPoints = [RestaurantPointAnnotation]()
  var crowdImage: UIImage!
  
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
  
  @IBAction func addReport(sender: UIBarButtonItem) {
    let alertController = UIAlertController(title: "Estimated Time", message: nil, preferredStyle: .ActionSheet)
    let levelOne = UIAlertAction(title: "5 minute", style: .Default, handler: { (action) -> Void in
      self.addTimeReport("5")
    })
    let levelTwo = UIAlertAction(title: "10 minute", style: .Default, handler: { (action) -> Void in
      self.addTimeReport("10")
    })
    let levelThree = UIAlertAction(title: "15 minute", style: .Default, handler: { (action) -> Void in
      self.addTimeReport("15")
    })
    let delete = UIAlertAction(title: "Add a photo", style: .Destructive) { (action) -> Void in
      self.openCamera()
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
      self.navigationController?.setToolbarHidden(true, animated: true)
      self.navigationController?.setNavigationBarHidden(false, animated: true)
      if let destVC = segue.destinationViewController as? ReportsTableViewController {
        if let annotationView = sender as? MKAnnotationView {
          if let annotation = annotationView.annotation as? RestaurantPointAnnotation {
            destVC.restaurantId = annotation.id
            destVC.restaurantTitle = annotation.title
            destVC.navigationController?.navigationItem.title = annotation.title
          }
        }
      }
    }
    
    if segue.identifier ==  "MapToPhoto" {
      self.navigationController?.setToolbarHidden(true, animated: true)
      self.navigationController?.setNavigationBarHidden(false, animated: true)
      if let destVC = segue.destinationViewController as? AddPhotoReportViewController {
        destVC.photo = crowdImage
      }
    }
  }
  
  @IBAction func tapRefresh(sender: UIBarButtonItem) {
    self.retrieveRestaurants()
  }
  
  @IBAction func tapCurrentLocation(sender: UIBarButtonItem) {
    self.locationManager.startUpdatingLocation()
  }
  
  func initLocationManager() {
    self.locationManager.delegate = self
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    self.locationManager.requestAlwaysAuthorization()
    self.locationManager.startUpdatingLocation()
  }
  
  func retrieveRestaurants() {
    let apiURL = API.sharedInstance.getListRestaurantsAPI()
    
    Alamofire.request(.GET, apiURL)
      .responseJSON {
        response in
        if let json = response.result.value {
          let data = json["data"] as! NSArray
          for restaurant in data {
            let newRestaurant = RestaurantPointAnnotation()
            let id = restaurant["_id"] as! String
            newRestaurant.id = id
            let attributes = restaurant["attribute"] as! NSDictionary
            newRestaurant.title = attributes["name"] as? String
            newRestaurant.waiting = attributes["waiting"] as! Int
            newRestaurant.subtitle = "\(newRestaurant.waiting) min waiting"
            let location = attributes["loc"] as! NSDictionary
            let coordinates = location["coordinates"] as! NSArray
            let latitude = coordinates[0] as! Double
            let longitude = coordinates[1] as! Double
            let geoLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            newRestaurant.coordinate = geoLocation
            self.restaurantPoints.append(newRestaurant)
          }
          
          self.cfMapView.removeAnnotations(self.cfMapView.annotations)
          self.cfMapView.addAnnotations(self.restaurantPoints)
          self.cfMapView.showAnnotations(self.restaurantPoints, animated: true)
        }
    }
  }
  
  // - MARK
  // Pick from camera or gallary
  //
  func openCamera() {
    let picker:UIImagePickerController = UIImagePickerController()
    picker.delegate = self
    if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
      picker.sourceType = UIImagePickerControllerSourceType.Camera
      self.presentViewController(picker, animated: true, completion: nil)
    } else {
      openGallary(picker)
    }
  }
  
  func openGallary(picker: UIImagePickerController!) {
    picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
      self.presentViewController(picker, animated: true, completion: nil)
    }
  }

  //----------------------------------------------------------------------------------------------------------------------
  // APIs
  //----------------------------------------------------------------------------------------------------------------------
  func addTimeReport(reportTime: String) {
    let api = API()
    let currentLocationId = "5619f748e4b0789ae18730d1"
    let apiURL = api.postRestaurantReportAPI(currentLocationId)
    let parameters = [
      "userId": "Jinyue",
      "waiting": reportTime
    ]
    
    Alamofire.request(.POST, apiURL, parameters: parameters, encoding: .JSON)
      .responseJSON {
        response in
        if let json = response.result.value {
          print(json)
        }
      }

  }
  
  class RestaurantPointAnnotation: MKPointAnnotation {
    var id: String!
    var waiting: Int!
    func toString() -> String {
      return "[id: \(self.id), name: \(self.title), waiting: \(self.waiting), coordinates: \(self.coordinate)]"
    }
  }
  
}



