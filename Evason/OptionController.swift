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

class OptionController: NSViewController {

    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        print("OptionController loaded")
        super.viewDidLoad()
        
        if let view = self.skView {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "options") {
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
    
    @IBAction func didClickExit(sender:AnyObject) {
        let storyBoard = NSStoryboard(name: "Main", bundle: nil)
        let splashViewController = storyBoard.instantiateController(withIdentifier: "SplashController") as! SplashViewController
        
        if let window = NSApplication.shared.windows.first {
            // you can now modify window attributes
            window.contentViewController = splashViewController
        }
    }
}

