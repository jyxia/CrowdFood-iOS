//
//  MapView+ImagePickerDelegates.swift
//  CrowdFood
//
//  Created by Jinyue Xia on 6/3/16.
//  Copyright © 2016 Jinyue Xia. All rights reserved.
//

import UIKit

extension MapViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  
  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    picker.dismissViewControllerAnimated(true, completion: nil)
  }
  
  // after picking or taking a photo didFinishPickingMediaWithInfo
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    picker.dismissViewControllerAnimated(true, completion: nil)
    crowdImage = info[UIImagePickerControllerOriginalImage] as? UIImage
    self.performSegueWithIdentifier("MapToPhoto", sender: self)
  }
  
}
