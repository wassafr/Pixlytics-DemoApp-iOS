//
//  ItemEditingTableViewController.swift
//  PixlyticsSDKAppDemo
//
//  Created by Bertrand VILLAIN on 05/04/2019.
//  Copyright © 2019 Wassa. All rights reserved.
//

import UIKit
import Pixlytics_SDK

/**
 *  This viewController lists all the ModelItems from WS (Paginated -> displayed items progressively when scrolling)
 */
class ItemEditingTableViewController: UITableViewController {
  
  var models: [ModelItem] = []
  var selectedItems: [ModelItem] = []
  var lastLoadedPages: PageInformation?
  var isLoading = false
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return models.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let tableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "ModelItemTableViewCell") as! ModelItemTableViewCell
    tableViewCell.loadData(modelItem: models[indexPath.row])
    return tableViewCell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let modelItem = self.models[indexPath.row]
    self.selectedItems.append(modelItem)
  }
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let height = scrollView.frame.size.height
    let contentYoffset = scrollView.contentOffset.y
    let distanceFromBottom = scrollView.contentSize.height - contentYoffset
    if distanceFromBottom < height {
      if isLoading {
        return
      } else {
        isLoading = true
        self.loadMoreItemsIfNeeded()
      }
    }
  }
  
  /**
   *  When reaching the bottom loads more ModelItems in the TableView
   */
  func loadMoreItemsIfNeeded() {
    if let page = self.lastLoadedPages,
      page.isLastPage() {
      return
    }
    let pageToLoad = (self.lastLoadedPages?.page ?? 0) + 1
    let itemPerPage = 10
    
    PixlyticsService.shared.online?.getModelItems(page: pageToLoad, itemPerPage: itemPerPage, success: { (wsModels, pageInfo) in
      
      self.models.append(contentsOf: wsModels)
      self.lastLoadedPages = pageInfo
      self.isLoading = false
      self.tableView.reloadData()
    }) { (error) in
      self.simpleAlert("Error", error?.localizedDescription)
    }
  }
  
  /**
   *  Unselect the cells in the tableview and clear the models in array
   */
  func unselectAllItems(andRemove: Bool) {
    for indexPath in tableView.indexPathsForSelectedRows ?? [] {
      tableView.deselectRow(at: indexPath, animated: true)
    }
    self.models.removeAll { (modelItem) -> Bool in
      if selectedItems.contains(where: { (selectedItem) -> Bool in
        if selectedItem.id == modelItem.id {
          return true
        }
        return false
      }) {
        return andRemove
      }
      return false
    }
    self.selectedItems.removeAll()
    self.tableView.reloadData()
  }
  
}
