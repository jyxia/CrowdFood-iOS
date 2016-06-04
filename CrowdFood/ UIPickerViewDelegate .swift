//
//  AddPhotoReport+Picker.swift
//  CrowdFood
//
//  Created by Jinyue Xia on 6/3/16.
//  Copyright © 2016 Jinyue Xia. All rights reserved.
//

import UIKit

extension AddPhotoReportViewController: UIPickerViewDelegate {

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
  
}