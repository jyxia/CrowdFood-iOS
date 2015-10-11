//
//  AddPhotoReportViewController.swift
//  CrowdFood
//
//  Created by Jinyue Xia on 10/11/15.
//  Copyright © 2015 Jinyue Xia. All rights reserved.
//

import UIKit
import Alamofire

class AddPhotoReportViewController: UIViewController, UIPickerViewDelegate, CLUploaderDelegate {
  
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
    self.uploadToCloudinary()
  }
  
  //----------------------------------------------------------------------------------------------------------------------
  // pickerView
  //----------------------------------------------------------------------------------------------------------------------
  
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerData.count
  }
  
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return String(pickerData[row])
  }
  
  func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
    let frame = pickerView.bounds
    let pickerLabel = UILabel(frame: CGRectInset(frame, 0, 0))
    pickerLabel.textAlignment = .Center
    let titleData = pickerData[row]
    pickerLabel.text = String(titleData) + " Minutes"
    pickerLabel.font = UIFont.systemFontOfSize(18)
    if row <= 5 {
      pickerLabel.textColor = UIColor.greenColor()
    } else if row > 5 && row <= 10 {
      pickerLabel.textColor = UIColor.orangeColor()
    } else if row > 10 {
      pickerLabel.textColor = UIColor.redColor()
    }
    
    return pickerLabel
  }
  
  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    self.pickedMintues = pickerData[row]
  }
  
  //----------------------------------------------------------------------------------------------
  // cloudinary upload
  //----------------------------------------------------------------------------------------------
  func uploadToCloudinary() {
    let forUpload = UIImageJPEGRepresentation(photo, 0.8)
    cloudinary.config().setValue("jxia", forKey: "cloud_name")
    cloudinary.config().setValue("589816318335168", forKey: "api_key")
    cloudinary.config().setValue("ScuqoitUPjgg_SS126L6xPEKkgQ", forKey: "api_secret")

    let uploader = CLUploader(cloudinary, delegate: self)
    uploader.upload(forUpload, options: nil, withCompletion:onCloudinaryCompletion, andProgress:onCloudinaryProgress)
  }
  
  func onCloudinaryCompletion(successResult:[NSObject : AnyObject]!, errorResult:String!, code:Int, idContext:AnyObject!) {
    // print(successResult)
    let publicURL = successResult["secure_url"] as! String
    print("now cloudinary uploaded, public url is: \(publicURL), ready for uploading media")
    sendPhotoReport(publicURL)
    self.uploadProgressView.setProgress(0, animated: false)
  }
  
  func onCloudinaryProgress(bytesWritten:Int, totalBytesWritten:Int, totalBytesExpectedToWrite:Int, idContext:AnyObject!) {
    let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite) as Float
    self.uploadProgressView.setProgress(progress, animated: false)
    print("uploading to cloudinary... wait! \(progress * 100)%")
    if progress == 1 {
      self.navigationController?.popViewControllerAnimated(true)
    }
  }
  
  func sendPhotoReport(url: String) {
    let api = API()
    let currentLocationId = "5619f748e4b0789ae18730d1"
    let apiURL = api.postRestaurantReportAPI(currentLocationId)
    let waitingTime = self.pickerData[self.timePicker.selectedRowInComponent(0)]
    let waiting = String(waitingTime)
    
    let parameters = [
      "userId": "Jinyue",
      "photoUrl": url,
      "waiting": waiting
    ]
    
    Alamofire.request(.POST, apiURL, parameters: parameters, encoding: .JSON)
      .responseJSON {
        response in
        if let json = response.result.value {
          print(json)
        }
    }
    
  }

  
}
