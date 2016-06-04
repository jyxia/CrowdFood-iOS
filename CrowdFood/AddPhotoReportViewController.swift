//
//  AddPhotoReportViewController.swift
//  CrowdFood
//
//  Created by Jinyue Xia on 10/11/15.
//  Copyright © 2015 Jinyue Xia. All rights reserved.
//

import UIKit
import Alamofire

class AddPhotoReportViewController: UIViewController {
  
  var photo: UIImage!
  @IBOutlet weak var timePicker: UIPickerView!
  @IBOutlet weak var previewImage: UIImageView!
  @IBOutlet weak var minutesPicker: UIPickerView!
  @IBOutlet weak var uploadProgressView: UIProgressView!
  
  var pickerData = [Int]()
  var cloudinary:CLCloudinary = CLCloudinary()
  var pickedMintues: Int?

  override func viewDidLoad() {
    super.viewDidLoad()
    previewImage.image = photo
    timePicker.delegate = self
    for i in 1...15 {
      let reportMinutes = i
      pickerData.append(reportMinutes)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: true)
    self.navigationController?.setToolbarHidden(false, animated: true)
  }

  @IBAction func tapDoneButton(sender: UIBarButtonItem) {
    uploadToCloudinary()
  }
  
  func uploadToCloudinary() {
    let forUpload = UIImageJPEGRepresentation(photo, 0.8)
    cloudinary.config().setValue("jxia", forKey: "cloud_name")
    cloudinary.config().setValue("589816318335168", forKey: "api_key")
    cloudinary.config().setValue("ScuqoitUPjgg_SS126L6xPEKkgQ", forKey: "api_secret")
    let uploader = CLUploader(cloudinary, delegate: self)
    uploader.upload(forUpload, options: nil, withCompletion:onCloudinaryCompletion, andProgress:onCloudinaryProgress)
  }
  
}
