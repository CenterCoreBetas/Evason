//
//  TitleScene.swift
//  Evason
//
//  Created by Yashas Valmikam on 1/12/19.
//  Copyright © 2019 (sample developer). All rights reserved.
//
import SpriteKit
import GameplayKit

class TitleMenu: SKScene, SKPhysicsContactDelegate {
    
    
    override func didMove(to view: SKView) {
    }
    
    // Replaces the viewcontroller in the main window
    
    func gotoGameViewController() {
        
        let storyBoard = NSStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateController(withIdentifier: "GameViewController") as! GameViewController
        
        
        if let window = NSApplication.shared.windows.first {
            // you can now modify window attributes
            window.contentViewController = viewController
            
        }
        
    }
    func gotooptioncontroller() {
        
        let storyBoard = NSStoryboard(name: "Main", bundle: nil)
        let optionController = storyBoard.instantiateController(withIdentifier: "OptionController") as! OptionController
        
        
        if let window = NSApplication.shared.windows.first {
            // you can now modify window attributes
            window.contentViewController = optionController
            
        }
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
        /*if let n = self.spinnyNode?.copy() as! SKShapeNode? {
         n.position = pos
         n.strokeColor = SKColor.green
         self.addChild(n)
         }*/
        let node = self.atPoint(pos)
        if (node.name == "LaunchButton") {
            self.gotoGameViewController()
        }
        if (node.name == "OptionButton") {
            self.gotooptioncontroller()
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        /*if let n = self.spinnyNode?.copy() as! SKShapeNode? {
         n.position = pos
         n.strokeColor = SKColor.blue
         self.addChild(n)
         }*/
    }
    
    func touchUp(atPoint pos : CGPoint) {
        /*if let n = self.spinnyNode?.copy() as! SKShapeNode? {
         n.position = pos
         n.strokeColor = SKColor.red
         self.addChild(n)
         }*/
    }
    
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.touchMoved(toPoint: event.location(in: self))
    }
    
    override func mouseUp(with event: NSEvent) {
        self.touchUp(atPoint: event.location(in: self))
    }
}

