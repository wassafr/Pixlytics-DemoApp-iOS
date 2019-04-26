//
//  ModelItemTableViewCell.swift
//  PixlyticsSDKAppDemo
//
//  Created by Bertrand VILLAIN on 05/04/2019.
//  Copyright © 2019 Wassa. All rights reserved.
//

import UIKit
import Kingfisher
import Pixlytics_SDK

class ModelItemTableViewCell: UITableViewCell {
  
  
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var itemNameLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  
  func loadData(modelItem: ModelItem) {
    
    iconImageView.layer.masksToBounds = true
    iconImageView.layer.cornerRadius = 8
    if let firstImageUrl = modelItem.images.first?.imageUrl,
      let url = URL(string: firstImageUrl) {
      iconImageView.kf.setImage(with: url)
    }
    itemNameLabel.text = modelItem.name
    if let firstName = modelItem.author?.firstName,
      let lastName = modelItem.author?.lastName {
      authorLabel.text = "\(firstName) \(lastName)"
    }
  }
  
}
