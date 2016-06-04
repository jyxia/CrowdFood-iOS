//
//  Report.swift
//  CrowdFood
//
//  Created by Jinyue Xia on 6/3/16.
//  Copyright © 2016 Jinyue Xia. All rights reserved.
//

struct Report {
  var waiting: Int!
  var user: String!
  var elapsedTime: Int!
  var confirms: Int!
  var photoURL: String!
  
  func toString() -> String {
    return "[user: \(user), waiting: \(waiting), confirms: \(confirms), elapseTime: \(elapsedTime)]"
  }
}
