//
//  AddReportViewController.swift
//  CrowdFood
//
//  Created by Jinyue Xia on 10/10/15.
//  Copyright © 2015 Jinyue Xia. All rights reserved.
//

import UIKit

class AddReportViewController: UIViewController {

  @IBOutlet weak var addphotoButton: UIButton!
  @IBOutlet weak var fifteenBtn: UIButton!
  
  override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
    visualEffectView.frame = addphotoButton.bounds
    addphotoButton.addSubview(visualEffectView)
    
    let visualEffectView2 = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
    visualEffectView2.frame = fifteenBtn.bounds
    fifteenBtn.addSubview(visualEffectView2)
    
//    let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "buttonDone")
//    self.navigationController?.navigationItem.rightBarButtonItem = doneButton
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func buttonDone() {
    
  }
  
  @IBAction func addphoto(sender: AnyObject) {
    print("add photo")
  }
  
}
