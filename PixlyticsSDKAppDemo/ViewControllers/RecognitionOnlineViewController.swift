//
//  RecognitionOnlineViewController.swift
//  PixlyticsSDKAppDemo
//
//  Created by Bertrand VILLAIN on 28/03/2019.
//  Copyright © 2019 Wassa. All rights reserved.
//

import UIKit
import Pixlytics_SDK

/**
 *  This class provides an example to perform an image recognition online on the server Pixlytics
 *  It also provides an example for downloading and loading a trained model
 */
class RecognitionOnlineViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  
  var imagePicker: UIImagePickerController!
  var imageForReco: UIImage?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.imageView.layer.masksToBounds = true
    self.imageView.layer.cornerRadius = 10
    
  }
  
  // MARK: IBActions

  /******************************************************************************************
   ***                                 TAKE PICTURE                                       ***
   ******************************************************************************************/
  
  @IBAction func takePhoto(_ sender: Any) {
    imagePicker =  UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.sourceType = .camera
    
    present(imagePicker, animated: true, completion: nil)
  }
  
  /******************************************************************************************
   ***                                RECOGNIZE PICTURE                                   ***
   ******************************************************************************************/

  @IBAction func launchRecognition(_ sender: Any) {
    if let image = self.imageForReco {
      PixlyticsService.shared.online?.recognizeImage(image: image, success: { detections in
        let firstResult = detections.first?.pixImage?.modelItem
        self.performSegue(withIdentifier: "DisplayResultViewController", sender: firstResult)
      }) { (error) in
        self.simpleAlert("Error".localized, error?.localizedDescription)
      }
    }
  }
  
  /**
   *  The result of the recognition is passed in parameter to the segue that displays the result
   *  If no recognition is sent, the "foundresult" boolean stays to false and the viewController displays that the recognition failed
   */
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let resultVC = segue.destination as? DisplayResultViewController,
      let modelItem = sender as? ModelItem {
      resultVC.modelItem = modelItem
    }
  }
  
}

extension RecognitionOnlineViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
  {
    imagePicker.dismiss(animated: true, completion: nil)
    imageView.image = info[.originalImage] as? UIImage
    self.imageForReco = info[.originalImage] as? UIImage
  }
  
}
