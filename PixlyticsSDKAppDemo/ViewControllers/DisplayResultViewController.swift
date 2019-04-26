//
//  DisplayResultViewController.swift
//  PixlyticsSDKAppDemo
//
//  Created by Bertrand VILLAIN on 09/04/2019.
//  Copyright © 2019 Wassa. All rights reserved.
//

import UIKit
import Kingfisher
import Pixlytics_SDK

/**
 *  This class displays the result of a recognition (offline or online), it can handle the result with or without ModelItem provided
 *  In the case no ModelItem is provided the viewController displays a default image
 *  When the recognition is done offline, you have to implement your own system to retrieve the ModelItem from ItemId (for example DataBase)
 */
class DisplayResultViewController: UIViewController {
  
  @IBOutlet weak var resultImageView: UIImageView!
  @IBOutlet weak var itemLabelView: UIView!
  @IBOutlet weak var itemLabel: UILabel!
  
  var modelItem: ModelItem?
  var foundResult = false
  var id: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.resultImageView.layer.masksToBounds = true
    self.resultImageView.layer.cornerRadius = 10
    self.itemLabelView.layer.cornerRadius = 8
    self.itemLabelView.isHidden = true
    if let modelItem = modelItem {
      resultFoundWithModel(item: modelItem)
    } else if foundResult {
      resultFound()
    } else {
      noResultFound()
    }
    self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissViewController)))
    
    ///We automatically dismiss the view after 5 seconds
    DispatchQueue.main.asyncAfter(wallDeadline: .now() + 5) {
      self.dismissViewController()
    }
  }

  /**
   *  Handles the case a ModelItem has been found (Online) from recognition
   */
  func resultFoundWithModel(item: ModelItem) {
    if let url = URL(string: item.images[0].imageUrl) {
      self.resultImageView.kf.setImage(with: url)
    }
    self.itemLabelView.isHidden = false
    itemLabel.text = "Name: \(item.name)"
  }

  /**
   *  Handles the case a result has been found (Offline) from recognition
   */
  func resultFound() {
     self.resultImageView.image = #imageLiteral(resourceName: "reco_result_found")
    if let id = id {
      self.itemLabel.text = "ID: \(id)"
      self.itemLabelView.isHidden = false
    }
  }
  
  /**
   *  Handles the case no result were found (Offline and Online)
   */
  func noResultFound() {
    self.resultImageView.image = #imageLiteral(resourceName: "reco_no_result_found")
  }
  
  @objc func dismissViewController() {
    self.dismiss(animated: true, completion: nil)
  }
}
