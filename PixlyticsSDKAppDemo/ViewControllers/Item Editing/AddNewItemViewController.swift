//
//  AddNewItemViewController.swift
//  PixlyticsSDKAppDemo
//
//  Created by Bertrand VILLAIN on 08/04/2019.
//  Copyright © 2019 Wassa. All rights reserved.
//

import UIKit

/**
 *  This viewController aims at creating a new ModelItem on Pixlytics server
 */
class AddNewItemViewController: UIViewController {
  
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var addIconImage: UIImageView!
  @IBOutlet weak var imageItem: UIImageView!
  
  ///List of images intended to fill up your ModelItem
  var selectedImages: [UIImage] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "screen_title_add_new_item".localized.uppercased()
    addIconImage.image = addIconImage.image?.withRenderingMode(.alwaysTemplate)
    addIconImage.tintColor = UIColor.white
    self.hideKeyboardWhenTappedAround()
    self.imageItem.layer.cornerRadius = 8
    self.imageItem.layer.masksToBounds = true
  }
  
  /**
   *  Add a picture from your library to the list of images
   */
  func askForPictureLibrary() {
    
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
      let imagePicker = UIImagePickerController()
      imagePicker.delegate = self
      imagePicker.sourceType = .photoLibrary;
      imagePicker.allowsEditing = true
      self.present(imagePicker, animated: true, completion: nil)
    }
    
  }
  
  //MARK: IBAction
  
  /**
   *  Present the controller to take a picture
   */
  @IBAction func addPicture(_ sender: Any) {
    self.askForPictureLibrary()
  }
  
  /**
   *  Add a new item on the server Pixlytics (in your session) with name and images filled on this viewController
   */
  @IBAction func saveItem(_ sender: Any) {
    if let name = self.nameTextField.text,
      self.selectedImages.count > 0 {
      PixlyticsService.shared.online?.addModelItem(itemName: name, images: self.selectedImages, success: nil) { (error) in
        if let error = error {
          self.simpleAlert("error".localized, error.localizedDescription, {
            self.dismiss(animated: true, completion: nil)
          })
        } else {
          self.dismiss(animated: true, completion: nil)
        }
      }
    } else {
      self.simpleAlert("error".localized, "missing_fields".localized)
    }
  }
  
}

extension AddNewItemViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    picker.dismiss(animated: true)
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      self.imageItem.image = image
      self.selectedImages.append(image)
    }
    
  }
}
