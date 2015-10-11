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
  
  init() {
    self.root = "http://crowdfood.mybluemix.net/api/"
  }
  
  func getListRestaurantsAPI() -> String {
    return root + "restaurants/short/"
  }
}