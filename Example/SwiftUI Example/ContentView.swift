//
//  ContentView.swift
//  SwiftUI Example
//
//  Created by MacBook Pro on 23/02/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import SwiftUI
import ScreenShield


struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .protectScreenshot()
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
