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
            Text("Sensative Information")
                .padding(.bottom, 50)
                .font(.title)
            Image("sensitive1")
                .resizable()
                .frame(maxWidth: .infinity)
                .aspectRatio(contentMode: .fit)
        }
        .padding()
        .protectScreenshot()
        .onAppear {
            ScreenShield.shared.protectFromScreenRecording()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
