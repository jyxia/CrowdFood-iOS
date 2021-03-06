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
  var restaurantTitle: String!
  var reports = [Report]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = self.restaurantTitle
    self.refreshControl?.tintColor = UIColor.darkGrayColor()
    // do not set title in viewDidLoad, it causes a big gap on the top tableview after pull to refresh
    // self.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
    self.refreshControl?.addTarget(self, action: #selector(ReportsTableViewController.refreshReportList), forControlEvents: UIControlEvents.ValueChanged)
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
    let elapsedTime = self.reports[indexPath.row].elapsedTime
    var passTime: String = String(self.reports[indexPath.row].elapsedTime) + " mins ago"
    if elapsedTime > 60 && elapsedTime < 1440 {
      passTime = String(elapsedTime / 60) + " hours ago"
    }
    if elapsedTime > 1440 {
      passTime = String(elapsedTime / 1440) + " days ago"
    }
    
    cell.userLabel.text = "submitted by " + self.reports[indexPath.row].user
    cell.waitingTimeLabel.text = String(self.reports[indexPath.row].waiting) + " mins waiting"
    cell.reportTimeLabel.text = passTime
    cell.confirmsLabel.text = String(self.reports[indexPath.row].confirms)
    if let url = self.reports[indexPath.row].photoURL {
      loadImage(url, imageView: cell.imageView!)
    } else {
      cell.imageView!.image = UIImage(named: "Future")
    }
    return cell
  }

  func retrieveReports() {
    let api = API.sharedInstance.getRestaurantReportsAPI(restaurantId)
    Alamofire.request(.GET, api)
      .responseJSON {
        response in
        if let json = response.result.value {
          self.reports = [Report]()
          let data = json["data"] as! NSDictionary
          let attributes = data["attribute"] as! NSDictionary
          let reports = attributes["reports"] as! NSArray
          for report in reports {
            var newReport = Report()
            newReport.waiting = report["waiting"] as! Int
            newReport.confirms = report["confirm"] as! Int
            newReport.user = report["userId"] as! String
            newReport.elapsedTime = report["timeSubmitted"] as! Int
            if let url = report["photoUrl"] as? String {
              newReport.photoURL = self.createThumbCloudinaryLink(url, width: 70, height: 70)
            }
            self.reports.append(newReport)
            self.reports.sortInPlace({ $0.elapsedTime < $1.elapsedTime })
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
          }
          
        }
    }
  }
  
  func loadImage(url: String, imageView: UIImageView) {
    let imageURL = NSURL(string: url)
    if let imageData = NSData(contentsOfURL: imageURL!) {
      if let image = UIImage(data: imageData) {
        imageView.image = image
      }
    }
  }

  func createThumbCloudinaryLink(url: String, width: Int, height: Int) -> String {
    let urlArr = url.characters.split{$0 == "/" }.map(String.init)
    var newURL = "https:"
    for str in urlArr {
      if str == "https:" {
        newURL += "/"
      } else {
        newURL += "/" + str
      }
      if str == "upload" {
        // newURL += "/w_600,h_600,c_fit"
        newURL += "/w_\(width),h_\(height),c_scale"
      }
    }
    return newURL
  }
  
  func refreshReportList() {
    retrieveReports()
  }
}
