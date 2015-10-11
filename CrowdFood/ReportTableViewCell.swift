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
  @IBOutlet weak var upImage: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
