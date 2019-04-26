//
//  RoundedButton.swift
//  PixlyticsSDKAppDemo
//
//  Created by Bertrand VILLAIN on 08/04/2019.
//  Copyright © 2019 Wassa. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.setTitleColor(.white, for: .normal)
    self.layer.cornerRadius = 8
    self.clipsToBounds = true
  }
  
}
