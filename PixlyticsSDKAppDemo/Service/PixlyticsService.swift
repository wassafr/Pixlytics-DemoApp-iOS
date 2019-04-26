//
//  PixlyticsService.swift
//  PixlyticsSDKAppDemo
//
//  Created by Bertrand VILLAIN on 05/04/2019.
//  Copyright © 2019 Wassa. All rights reserved.
//

import Foundation
import Pixlytics_SDK

class PixlyticsService {
  
  // MARK: - Properties
  
  //Singleton
  static let shared = PixlyticsService()
  //To prevent instantiation of class
  private init(){}
  
  /**
   *  In this service we init both service together, but you can keep only one of them if you don't need the other one
   */
  ///For doing offline recognition use this service
  var local: RecognitionSession?
  ///For doing online recognition, managing items, training and downloading trained models use this service
  var online: SessionOnline?

  func initService(licenseKey: String, failure: @escaping (Error?) -> ()) {
    if self.local == nil {
      self.local = RecognitionSession.init(licenseKey)
    }
    
    if self.online == nil {
      self.online = SessionOnline(licenceKey: licenseKey, alternativeUrl: nil, success: { () in
        failure(nil)
      }, failure: { (error) in
        failure(error)
      })
    }
  }
  
}
