//
//  Restaurant.swift
//  CrowdFood
//
//  Created by Jinyue Xia on 10/10/15.
//  Copyright © 2015 Jinyue Xia. All rights reserved.
//

import Foundation
import CoreLocation

class Restaurant {
  
  var id: String!
  var name: String!
  var waiting: Int!
  var coordinates: CLLocationCoordinate2D!
  
  func toString() -> String {
    return "[id: \(self.id), name: \(self.name), waiting: \(self.waiting), coordinates: \(self.coordinates)]"
  }
  
}