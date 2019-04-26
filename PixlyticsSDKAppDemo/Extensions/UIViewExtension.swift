//
//  UIViewExtension.swift
//  PixlyticsSDKAppDemo
//
//  Created by Bertrand VILLAIN on 28/03/2019.
//  Copyright © 2019 Wassa. All rights reserved.
//

import UIKit

extension UIView {
  
  func setBackgroundGradientColor(from colors: [UIColor]) {
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = self.bounds
    gradientLayer.colors = colors.map { (color) -> CGColor in
      return color.cgColor
    }
    
    self.layer.insertSublayer(gradientLayer, at: 0)
  }
  
}
