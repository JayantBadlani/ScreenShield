# ScreenShield
ScreenShield is an iOS library that provides a simple way to protect your app's content from being captured or recorded by screenshots, screen recordings, or other screen capture methods. It works by adding a secure layer on top of your views, which prevents most screen capture mechanisms from recording the underlying content.

The library supports both UIKit and SwiftUI and can be used with ease in both. It also provides a way to start and stop listening for screen recordings, and can be customized to use different types of views

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
    .package(url: "https://github.com/JayantBadlani/ScreenShield", from: "0.1.0")
]
Then, run swift package update to download the library and its dependencies.

## Usage
To use ScreenShield in your iOS app, simply import the library and call its methods to protect your views and listen for screen recordings.

### Here's an example of how to use the library with UIKit:

```ruby
import UIKit
import ScreenShield

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                ScreenShield.shared.protectFromScreenRecording // Protect Screen-Recording
            }
    }
}
```

That's it! With just a few lines of code, you can protect your app's content and prevent it from being recorded or captured by unwanted screen capture mechanisms.

License
ScreenShield is available under the MIT license. See the LICENSE file for more information.
