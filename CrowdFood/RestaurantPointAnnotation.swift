//
//  RestaurantPointAnnotation.swift
//  CrowdFood
//
//  Created by Jinyue Xia on 6/3/16.
//  Copyright © 2016 Jinyue Xia. All rights reserved.
//

import MapKit

class RestaurantPointAnnotation: MKPointAnnotation {
  var id: String!
  var waiting: Int!
  func toString() -> String {
    return "[id: \(self.id), name: \(self.title), waiting: \(self.waiting), coordinates: \(self.coordinate)]"
  }
}