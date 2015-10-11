//
//  ReportsTableViewController.swift
//  CrowdFood
//
//  Created by Jinyue Xia on 10/10/15.
//  Copyright © 2015 Jinyue Xia. All rights reserved.
//

import UIKit

class ReportsTableViewController: UITableViewController {
  
  var reports: [Report]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
      // Uncomment the following line to preserve selection between presentations
      // self.clearsSelectionOnViewWillAppear = false

      // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
      // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 1
    }
  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reportcell", forIndexPath: indexPath)


        return cell
    }
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  
  class Report {
    var waiting: Int!
    var user: String!
    var reportTime: Int!
    var confirms: Int!
  }

}
