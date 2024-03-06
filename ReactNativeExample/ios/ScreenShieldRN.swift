//
//  ScreenShield.swift
//  ReactNativeApp
//
//  Created by Gulsher Khan on 07/03/24.
//

import Foundation
import ScreenShield
import React

@objc(ScreenShieldRN)
class ScreenShieldRN: NSObject {

    @objc func protectScreenRecording() {
        ScreenShield.shared.protectFromScreenRecording()
    }

  @objc static func requiresMainQueueSetup() -> Bool {
       return true
   }
}

