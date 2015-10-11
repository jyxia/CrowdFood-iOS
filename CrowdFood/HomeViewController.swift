//
//  HomeViewController.swift
//  CrowdFood
//
//  Created by Jinyue Xia on 10/10/15.
//  Copyright © 2015 Jinyue Xia. All rights reserved.
//

import UIKit
import VideoSplash

class HomeViewController: VideoSplashViewController, VideoPlayerEventDelegate {
  
//  @IBOutlet weak var enterButton: UIButton!
  
  @IBOutlet weak var enterBtn: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let url = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("restaurant", ofType: "mp4")!)
    self.videoFrame = view.frame
    self.fillMode = .ResizeAspectFill
    self.alwaysRepeat = true
    self.sound = true
    self.startTime = 0.0
    self.alpha = 0.7
    self.backgroundColor = UIColor.blackColor()
    self.contentURL = url
    self.sound = false
    self.eventDelegate = self
    
    enterBtn.backgroundColor = UIColor.clearColor()
    enterBtn.layer.cornerRadius = 5
    enterBtn.layer.borderWidth = 1
    enterBtn.layer.borderColor = UIColor.greenColor().CGColor
    
    let text = UILabel(frame: CGRect(x: 0.0, y: 100.0, width: 320.0, height: 100.0))
    text.font = UIFont(name: "Museo500-Regular", size: 40)
    text.textAlignment = NSTextAlignment.Center
    text.textColor = UIColor.whiteColor()
    text.text = "Crowd Food"
    view.addSubview(text)
    
    
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    self.navigationController?.setToolbarHidden(false, animated: true)
  }
  
  @IBAction func tapEnter(sender: UIButton) {
    self.performSegueWithIdentifier("HomeToMap", sender: self)
  }
  
  func videoDidEnd() {
    self.performSegueWithIdentifier("HomeToMap", sender: self)
  }
  
}