//
//  AddPhotoReportViewController.swift
//  CrowdFood
//
//  Created by Jinyue Xia on 10/11/15.
//  Copyright © 2015 Jinyue Xia. All rights reserved.
//

import UIKit

class AddPhotoReportViewController: UIViewController {
  
  var photo: UIImage!
  
  @IBOutlet weak var previewImage: UIImageView!
  @IBOutlet weak var minutesPicker: UIPickerView!

  override func viewDidLoad() {
    super.viewDidLoad()
    previewImage.image = photo
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }


}
