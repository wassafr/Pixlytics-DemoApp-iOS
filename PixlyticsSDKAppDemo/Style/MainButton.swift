//
//  MainButton.swift
//  PixlyticsSDKAppDemo
//
//  Created by Bertrand VILLAIN on 28/03/2019.
//  Copyright © 2019 Wassa. All rights reserved.
//

import UIKit

class MainButton: RoundedButton {
  
  override func awakeFromNib() {
    self.setBackgroundGradientColor(from: [#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1), #colorLiteral(red: 0.1685473954, green: 0.09365525534, blue: 0.3529411765, alpha: 1)])
    super.awakeFromNib()
    if let text = self.titleLabel?.text {
      self.setTitle(text.uppercased(), for: .normal)
    }
  }  
  
  
  
  override func layoutSubviews() {
    self.setBackgroundGradientColor(from: [#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1), #colorLiteral(red: 0.168627451, green: 0.09411764706, blue: 0.3529411765, alpha: 1)])
    super.layoutSubviews()
  }
}
