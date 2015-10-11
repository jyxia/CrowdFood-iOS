//
//  ReportTableViewCell.swift
//  CrowdFood
//
//  Created by Jinyue Xia on 10/10/15.
//  Copyright © 2015 Jinyue Xia. All rights reserved.
//

import UIKit

class ReportTableViewCell: UITableViewCell {

  @IBOutlet weak var waitingTimeLabel: UILabel!
  @IBOutlet weak var userLabel: UILabel!
  @IBOutlet weak var reportTimeLabel: UILabel!
  @IBOutlet weak var confirmsLabel: UILabel!
  @IBOutlet weak var upButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  @IBAction func upButtonTouch(sender: UIButton) {
    if let confirms = self.confirmsLabel.text {
      var numbers = Int(confirms)
      ++numbers!
      confirmsLabel.text = String(numbers!)
      upButton.imageView!.image = UIImage(named: "ThumbupGrey")
      upButton.enabled = false
    }
  }
  
}
