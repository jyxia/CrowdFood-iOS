//
//  AddPhoto+CloudinaryDelegates.swift
//  CrowdFood
//
//  Created by Jinyue Xia on 6/3/16.
//  Copyright © 2016 Jinyue Xia. All rights reserved.
//

import Alamofire

extension AddPhotoReportViewController: CLUploaderDelegate {

  func onCloudinaryCompletion(successResult:[NSObject : AnyObject]!, errorResult:String!, code:Int, idContext:AnyObject!) {
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