//
//  UIViewControllerExtension.swift
//  PixlyticsSDKAppDemo
//
//  Created by Bertrand VILLAIN on 05/04/2019.
//  Copyright © 2019 Wassa. All rights reserved.
//

import UIKit

extension UIViewController {

  func simpleAlert(_ title: String?, _ message: String?, _ completion: (() -> Void)? = nil) {
    let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
      completion?()
    }))
    self.present(alertVC, animated: true, completion: nil)
  }
  
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}
