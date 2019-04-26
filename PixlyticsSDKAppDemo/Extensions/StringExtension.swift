//
//  StringExtension.swift
//  PixlyticsSDKAppDemo
//
//  Created by Bertrand VILLAIN on 08/04/2019.
//  Copyright © 2019 Wassa. All rights reserved.
//

import Foundation

extension String {
  var localized: String { get { return NSLocalizedString(self, comment: "")} }
  
}
