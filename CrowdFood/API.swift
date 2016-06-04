//
//  API.swift
//  CrowdFood
//
//  Created by Jinyue Xia on 10/10/15.
//  Copyright © 2015 Jinyue Xia. All rights reserved.
//

import Foundation

class API {

  var root: String
  static let sharedInstance = API()
  
  init() {
    self.root = "http://crowdfood.mybluemix.net/api/"
  }
  
  func getListRestaurantsAPI() -> String {
    return root + "restaurants/short/"
  }
  
  func getRestaurantReportsAPI(restaurantId: String) -> String {
    return root + "restaurants/" + restaurantId
  }
  
  func postRestaurantReportAPI(restaurantId: String) -> String {
    return root + "restaurants/" + restaurantId
  }
}