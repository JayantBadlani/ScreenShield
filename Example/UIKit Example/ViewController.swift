//
//  ViewController.swift
//  ScreenShield
//
//  Created by Jayant Badlani on 02/18/2023.
//  Copyright (c) 2023 Jayant Badlani. All rights reserved.
//

import UIKit
import ScreenShield

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ScreenShield.shared.protect(view: self.view)
        ScreenShield.shared.protectFromScreenRecording()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

