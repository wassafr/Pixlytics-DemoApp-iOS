//
//  ItemEditingViewController.swift
//  PixlyticsSDKAppDemo
//
//  Created by Bertrand VILLAIN on 28/03/2019.
//  Copyright © 2019 Wassa. All rights reserved.
//

import UIKit

/**
 *  This viewController shows how to edit the ModelItem on Pixlytics server and train a model from a selected list of items
 *  The TableView is in the container (of type ItemEditingTableViewController) and list all the ModelItems from WS (Paginated)
 */
class ItemEditingViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "screen_title_item_editing".localized.uppercased()
    if let childViewController = self.children.first as? ItemEditingTableViewController {
      childViewController.loadMoreItemsIfNeeded()
    }
  }
  
  // MARK: IBActions
  
  /**
   *  Select your list of items from the tableView and do the request to delete them on the Pixlytics DataBase
   */
  @IBAction func removeItems(_ sender: Any) {
    
    if let childViewController = self.children.first as? ItemEditingTableViewController {
      if childViewController.selectedItems.count > 0 {
        let publicIds = childViewController.selectedItems.map { (modelItem) -> Int in
          return modelItem.publicId
        }
        PixlyticsService.shared.online?.removeModelItems(ids: publicIds, success: {
          self.simpleAlert("success".localized, "successfully_deleted_items".localized, {
            childViewController.unselectAllItems(andRemove: true)
          })
        }) { (error) in
          self.simpleAlert("error".localized, error?.localizedDescription, nil)
        }
      } else {
        self.simpleAlert("error".localized, "error_select_item".localized, nil)
      }
    }
  }
  
  /**
   *  Select your list of items from the tableView and do the request to start the training on server
   */
  @IBAction func trainModel(_ sender: Any) {
    
    if let childViewController = self.children.first as? ItemEditingTableViewController {
      if childViewController.selectedItems.count > 0 {
        let publicIds = childViewController.selectedItems.map { (modelItem) -> Int in
          return modelItem.publicId
        }
        
        PixlyticsService.shared.online?.trainModel(ids: publicIds, success: {
          self.simpleAlert("success".localized, "successfully_trained_model".localized, {
            childViewController.unselectAllItems(andRemove: false)
          })
        }) { (error) in
          self.simpleAlert("error".localized, error?.localizedDescription, nil)
        }
        
      } else {
        self.simpleAlert("error".localized, "error_select_item".localized, nil)
      }
    }
  }
  
}
