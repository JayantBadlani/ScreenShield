# ScreenShield

ScreenShield is an iOS library that provides a simple way to protect your app's content from being captured or recorded by screenshots, screen recordings, or other screen capture methods. It works by adding a secure layer on top of your views, which prevents most screen capture mechanisms from recording the underlying content.

The library supports both UIKit and SwiftUI and can be used with ease in both. It also provides a way to start and stop listening for screen recordings, and can be customized to use different types of views

## Kindly give a Star ⭐ to my repo to support my work. Thank you!

![2](https://user-images.githubusercontent.com/37996543/220936399-8c1abe93-8356-4d8d-8e37-546029c58206.gif)

[![Version](https://img.shields.io/cocoapods/v/ScreenShield.svg?style=flat)](https://cocoapods.org/pods/ScreenShield)
[![License](https://img.shields.io/cocoapods/l/ScreenShield.svg?style=flat)](https://cocoapods.org/pods/ScreenShield)
[![Platform](https://img.shields.io/cocoapods/p/ScreenShield.svg?style=flat)](https://cocoapods.org/pods/ScreenShield)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

## CocoaPods
To install ScreenShield using CocoaPods, add the following line to your Podfile:

```ruby
pod 'ScreenShield'
```
Then, run pod install to install the library and its dependencies.

## Swift Package Manager
To install ScreenShield using Swift Package Manager, add the following line to your Package.swift:

dependencies: [
    .package(url: "https://github.com/JayantBadlani/ScreenShield", from: "1.2.1")
]
Then, run swift package update to download the library and its dependencies.

## Usage
To use ScreenShield in your iOS app, simply import the library and call its methods to protect your views and listen for screen recordings.

### Here's an example of how to use the library with UIKit:

```ruby
import UIKit
import ScreenShield
import React

class ViewController: UIViewController {
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        // Protect ScreenShot
        ScreenShield.shared.protect(view: self.view)
        
        // Protect Screen-Recording
        ScreenShield.shared.protectFromScreenRecording()
    }
}
```

### And here's an example of how to use the library with SwiftUI:


```ruby
import SwiftUI
import ScreenShield

struct ContentView: View {
    
    var body: some View {
        Text("Hello, World!")
            .protectScreenshot() // Protect the view
            .onAppear {
                ScreenShield.shared.protectFromScreenRecording() // Protect Screen-Recording
            }
    }
}
```


# Integrating ScreenShield SDK with React Native

This guide explains how to integrate the ScreenShield SDK into your React Native project to protect your app from screen recording.

## Installation

1. Install the ScreenShield SDK through CocoaPods. Follow the installation instructions provided in the ScreenShield documentation.

### Add this pod sdk in your podfile

```ruby
    pod 'ScreenShield'
```

## Usage

### 1. Add Swift File

Create a Swift file named `ScreenShieldRN.swift` under your iOS root directory with the following content:

```swift
import Foundation
import ScreenShield

@objc(ScreenShieldRN)
class ScreenShieldRN: NSObject {

    @objc func protectScreenRecording() {
        ScreenShield.shared.protectFromScreenRecording()
    }

    @objc static func requiresMainQueueSetup() -> Bool {
        return true
    }
}
```
### 2. Add Objective-C File
Create an Objective-C file named ScreenShieldRN.m and add the following code:

```objc
#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import "React/RCTLog.h"

@interface RCT_EXTERN_MODULE(ScreenShieldRN, NSObject)

RCT_EXTERN_METHOD(protectScreenRecording)

@end
```

### 3. Create a Bridge File
Create a bridge file named ScreenShieldRNBridge.h with the following code:

```objc

#import <React/RCTBridgeModule.h>
#import <React/RCTViewManager.h>
```

### Usage in React Native
Now, you can use the ScreenShield functionality in your React Native code. For example:

```javascript
import { NativeModules } from 'react-native';

const { ScreenShieldRN } = NativeModules;

ScreenShieldRN.protectScreenRecording(); // Call the protectScreenRecording method to protect from screen recording

```

That's it! With just a few lines of code, you can protect your app's content and prevent it from being recorded or captured by unwanted screen capture mechanisms.

## Note: 
Preventing screen capture in an iOS app presents challenges due to the lack of direct support from the iOS operating system. In our library, we've customized our code with various hacks and workarounds to achieve the desired result. Users may encounter occasional issues with a disrupted UI. To address this, consider the following approaches for different frameworks:

For UIKit:
To prevent the layout issue by incorporating "ScreenShield" protection to your view after the UI finishes loading. Implementing this protection in the viewDidAppear method can effectively mitigate layout problems.

For SwiftUI:
To prevent the layout issue, add the "ScreenShield" modifier to the outermost view in the hierarchy on the screen, ensuring a secure and protected user interface experience. 
## Please note that the library is currently under development, and contributions are greatly appreciated.


License
ScreenShield is available under the MIT license. See the LICENSE file for more information.

# Kindly give a Star ⭐ to my repo to support my work. Thank you!


