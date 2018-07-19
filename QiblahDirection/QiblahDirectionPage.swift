//
//  QiblahDirectionPage.swift
//  Salaat
//
//  Created by Karthick on 5/12/18.
//  Copyright © 2018 Karthick. All rights reserved.
//

import UIKit
import CoreLocation

class QiblahDirectionPage: UIViewController {
  
  var compassManager  : CompassDirectionManager!
  
  var screenWidth = CGFloat()
  var screenHeight = CGFloat()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.isNavigationBarHidden = false
    
    screenHeight = self.view.frame.size.height
    screenWidth = self.view.frame.size.width
    
    let navBarHeight = UIApplication.shared.statusBarFrame.height+30
    
    //Direction backgroun imageView
    let directionImage = UIImageView()
    if UIDevice.current.model.hasPrefix("iPad") {
      directionImage.frame = CGRect(x:screenWidth/2-screenWidth/4 ,y:navBarHeight ,width:screenWidth/2 ,height:screenHeight/3.5)
    } else {
      directionImage.frame = CGRect(x:screenWidth/2-screenWidth/4 ,y:navBarHeight ,width:screenWidth/2 ,height:screenHeight/4)
      if UIDevice().userInterfaceIdiom == .phone {
        switch UIScreen.main.nativeBounds.height {
          //        case 1136:
          //          print("iPhone 5 or 5S or 5C")
          //        case 1334:
          //          print("iPhone 6/6S/7/8")
          //        case 1920, 2208:
        //          print("iPhone 6+/6S+/7+/8+")
        case 2436:
          print("iPhone X")
          directionImage.frame = CGRect(x:screenWidth/2-screenWidth/4 ,y:navBarHeight ,width:screenWidth/2 ,height:(screenHeight/4)-40)
        default:
          print("unknown")
        }
      }
    }
    directionImage.image = #imageLiteral(resourceName: "directions")
    directionImage.contentMode = .scaleAspectFit
    directionImage.isUserInteractionEnabled = true
    self.view.addSubview(directionImage)
    
    //Compass Imageview creation
    let compassImage = UIImageView()
    if UIDevice.current.model.hasPrefix("iPad") {
      let widthImage = directionImage.frame.size.width/2-25
      compassImage.frame = CGRect(x:(directionImage.frame.size.width/2-directionImage.frame.size.width/4)+12 ,y:(directionImage.frame.size.height-directionImage.frame.size.width/2)+20 ,width:widthImage ,height:widthImage)
    } else {
      compassImage.frame = CGRect(x:directionImage.frame.size.width/2-directionImage.frame.size.width/4 ,y:directionImage.frame.size.height-directionImage.frame.size.width/2-3 ,width:directionImage.frame.size.width/2 ,height:directionImage.frame.size.width/2)
    }
    compassImage.image = #imageLiteral(resourceName: "Compass")
    compassImage.contentMode = .scaleAspectFit
    //compassImage.backgroundColor = .red
    directionImage.addSubview(compassImage)
    
    //Qiblah Direction image Creation
    let directionArrowImage = UIImageView()
    if UIDevice.current.model.hasPrefix("iPad") {
      directionArrowImage.frame = CGRect(x:directionImage.frame.size.width/2-50 ,y:directionImage.frame.size.height-150 ,width:100 ,height:100)
    }else{
      directionArrowImage.frame = CGRect(x:directionImage.frame.size.width/2-directionImage.frame.size.width/4 ,y:directionImage.frame.size.height/2-(directionImage.frame.size.width/6-25) ,width:directionImage.frame.size.width/2 ,height:(directionImage.frame.size.width/2)-20)
    }
    directionArrowImage.image = #imageLiteral(resourceName: "check1")
    directionArrowImage.contentMode = .scaleAspectFit
    //directionArrowImage.backgroundColor = .green
    directionImage.addSubview(directionArrowImage)
    
    
    //SetUP Direction Third party method
    compassManager =  CompassDirectionManager(dialerImageView: compassImage, pointerImageView: directionArrowImage)
    compassManager.initManager()
    
    
    let directionLabel = UILabel()
    directionLabel.frame = CGRect(x:10 ,y:screenHeight-screenHeight/4 ,width:screenWidth-20 ,height:45)
    directionLabel.text = "Qiblah" + " " + "Direction" + " " + "291°"
    directionLabel.font = UIFont.systemFont(ofSize: 22)
    directionLabel.textColor = UIColor.black
    directionLabel.textAlignment = .center
    self.view.addSubview(directionLabel)
    
  }
  override func viewWillAppear(_ animated: Bool) {
   // self.view = GradientView()
  }
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    if isMovingFromParentViewController {
      if let viewControllers = self.navigationController?.viewControllers {
        if (viewControllers.count >= 1) {
          let transition = CATransition()
          transition.duration = 0.5
          transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
          transition.type = kCATransitionFade
          transition.subtype = kCATransitionFromBottom
          navigationController?.view.layer.add(transition, forKey:kCATransition)
          let _ = navigationController?.popViewController(animated: false)
        }
      }
    }
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
