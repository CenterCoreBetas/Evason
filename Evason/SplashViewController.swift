//
//  ViewController.swift
//  Evason
//
//  Created by Yashas Valmikam on 12/21/18.
//  Copyright © 2018 Yashas Valmikam. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class SplashViewController: NSViewController {

    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        print("SplashViewController loaded")
        super.viewDidLoad()

        if let view = self.skView {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "TitleMenu") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .resizeFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}

