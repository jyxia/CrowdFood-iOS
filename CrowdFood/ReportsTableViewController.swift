//
//  ReportsTableViewController.swift
//  CrowdFood
//
//  Created by Jinyue Xia on 10/10/15.
//  Copyright © 2015 Jinyue Xia. All rights reserved.
//

import UIKit
import Alamofire

class ReportsTableViewController: UITableViewController {
  var restaurantId: String!
  var reports = [Report]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    retrieveReports()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: true)
    self.navigationController?.setToolbarHidden(false, animated: true)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return reports.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("reportcell", forIndexPath: indexPath) as! ReportTableViewCell
    cell.userLabel.text = "submitted by " + self.reports[indexPath.row].user
    cell.waitingTimeLabel.text = String(self.reports[indexPath.row].waiting) + " mins waiting"
    cell.reportTimeLabel.text = String(self.reports[indexPath.row].elapsedTime) + " mins ago"
    cell.confirmsLabel.text = String(self.reports[indexPath.row].confirms)
    return cell
  }

  func retrieveReports() {
    let api = API().getRestaurantReportsAPI(restaurantId)
    Alamofire.request(.GET, api)
      .responseJSON {
        response in
        if let json = response.result.value {
          let data = json["data"] as! NSDictionary
          let attributes = data["attribute"] as! NSDictionary
          let reports = attributes["reports"] as! NSArray
          for report in reports {
            let newReport = Report()
            newReport.waiting = report["waiting"] as! Int
            newReport.confirms = report["confirm"] as! Int
            newReport.user = report["userId"] as! String
            newReport.elapsedTime = report["timeSubmitted"] as! Int
            // print(newReport.toString())
            self.reports.append(newReport)
            self.tableView.reloadData()
          }
          
        }
    }
  }

  
  class Report {
    var waiting: Int!
    var user: String!
    var elapsedTime: Int!
    var confirms: Int!
    var photoURL: String!
    
    func toString() -> String {
      return "[user: \(user), waiting: \(waiting), confirms: \(confirms), elapseTime: \(elapsedTime)]"
    }
  }

}
