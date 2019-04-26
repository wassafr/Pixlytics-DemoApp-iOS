//
//  HomeViewController.swift
//  PixlyticsSDKAppDemo
//
//  Created by Bertrand VILLAIN on 28/03/2019.
//  Copyright © 2019 Wassa. All rights reserved.
//

import Foundation
import UIKit

/**
 *  This is the home ViewController, it gathers all the links to other pages
 *  When this ViewController is loaded we do the initialization of the Pixlytics SDK services
 */
class HomeViewController: UIViewController {
 
  /**
   * Change the following key by the license key we gave you by email
   * If you don't have any license key, contact cupport at support@pixlytics.io
   */
  let licenseForDemo = "INSERT_YOUR_LICENSE_KEY_HERE"
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.view.setBackgroundGradientColor(from: [#colorLiteral(red: 0.9490196078, green: 0.9529411765, blue: 0.9254901961, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
    PixlyticsService.shared.initService(licenseKey: licenseForDemo) { (error) in
      print("Init PixlyticsService: \(error?.localizedDescription ?? "✅")")
    }
  }
  
}
