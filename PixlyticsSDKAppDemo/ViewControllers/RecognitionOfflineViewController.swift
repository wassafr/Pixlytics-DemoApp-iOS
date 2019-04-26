//
//  RecognitionOfflineViewController.swift
//  PixlyticsSDKAppDemo
//
//  Created by Bertrand VILLAIN on 28/03/2019.
//  Copyright © 2019 Wassa. All rights reserved.
//

import UIKit
import Pixlytics_SDK
import JGProgressHUD

/**
 *  This class provides an example to perform an image recognition when you are offline
 *  It also provides an example for downloading and loading a trained model
 */
class RecognitionOfflineViewController: UIViewController {
  
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
    
    ///Displays the system camera
    present(imagePicker, animated: true, completion: nil)
  }

/******************************************************************************************
 ***                                RECOGNIZE PICTURE                                   ***
 ******************************************************************************************/

  @IBAction func startRecognition(_ sender: Any) {
    if let image = imageForReco {
      PixlyticsService.shared.online?.recognizeImage(image: image, success: { (result) in
        if let result = result.first {
          self.performSegue(withIdentifier: "DisplayResultViewController", sender: result)
        } else {
          self.performSegue(withIdentifier: "DisplayResultViewController", sender: nil)
        }
      }, failure: { (error) in
        self.simpleAlert("Error", error?.localizedDescription)
      })
    }
  }

  /*****************************************************************************************
   ***                             DOWNLOAD AND LOAD MODEL                               ***
   *****************************************************************************************/
  
  /**
   *  This metod download the training model for local recognition.
   *
   *  If a model is already present localy, it just erases it
   *  1 We firstly get the list of version from Pixlytics server
   *  2 Then we download the version we want from the server and unzip it to the destination path
   *  3 Then you have to load the model to your recognition session(local) before you make any recognition
   *
   *  ⚠️ Loading your trained model in your [RecognitionSession] is mandatory before you make any recognition ⚠️
   *  ⚠️ Just this part needs to be done when connected
   */
  @IBAction func downloadModel(_ sender: Any) {
    let hud = JGProgressHUD(style: .dark)
    hud.textLabel.text = "Loading"
    hud.show(in: self.view)
    //1 version
    PixlyticsService.shared.online?.getVersion(success: { (versions) in
      //2 Download and unzip
      PixlyticsService.shared.online?.unzipModelFrom(modelVersion: versions[0], success: { (destinationPath) in
        
        hud.dismiss()
        // 3 Loading
        // ⚠️ You can't use the local recognition if you didn't load a training model before
        PixlyticsService.shared.local?.loadModel(destinationPath.absoluteString, completion: { (errorLoadmodel) in
          self.simpleAlert("error".localized, "Failed to load model -> \(errorLoadmodel)")
        })
        
      }, failure: { (errorZip) in
        hud.dismiss()
        self.simpleAlert("error".localized, "fail_unzip_model".localized)
        print(errorZip?.localizedDescription ?? "error zip")
      })
    }) { (errorVersion) in
      hud.dismiss()
      self.simpleAlert("error".localized, "fail_list_versions".localized)
      print(errorVersion?.localizedDescription ?? "error version")
    }
    
  }
  
  /**
   *  The result of the recognition is passed in parameter to the segue that displays the result
   *  If no recognition is sent, the "foundresult" boolean stays to false and the viewController displays that the recognition failed
   */
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let resultVC = segue.destination as? DisplayResultViewController,
      let result = sender as? RecognitionResult {
      resultVC.foundResult = true
      resultVC.id = result.itemId as? Int
    }
  }
}

extension RecognitionOfflineViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
  {
    imagePicker.dismiss(animated: true, completion: nil)
    imageView.image = info[.originalImage] as? UIImage
    self.imageForReco = info[.originalImage] as? UIImage
  }
  
}
