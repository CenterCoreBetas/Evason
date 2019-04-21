//
//  GameScene.swift
//  Evason
//
//  Created by Yashas Valmikam on 12/21/18.
//  Copyright © 2018 Yashas Valmikam. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var cam: SKCameraNode?
    
    var holdingRight = false
    var holdingLeft = false
    var holdingUp = false
    var holdingDown = false
    var run = false
    var level = 0
    var facingLeft = false
    var moving = false
    var alwaysfalse = false
    var vframe = 0
    
    private var humanWalkingFramesForward: [SKTexture] = []
    private var humanWalkingFramesBackward: [SKTexture] = []
    private var yellowSquareBoxFrames: [SKTexture] = []
    
    func buildHuman(name:String) -> [SKTexture] {
        let humanAnimatedAtlas = SKTextureAtlas(named: name)
        var walkFrames: [SKTexture] = []
        
        let numImages = humanAnimatedAtlas.textureNames.count
        for i in 1...numImages {
            let textureName = "\(name)_\(i)"
            walkFrames.append(humanAnimatedAtlas.textureNamed(textureName))
        }
        return walkFrames
    }
    
    var increaseLevel = false
    
    func collisionBetween(object1: SKNode, object2: SKNode) {
        if(object1.name == "Brick" || object2.name == "Brick") {
            print("Brick collided with Goal")
            level = level + 1
            if let brickNode = self.childNode(withName: "//Brick") as? SKSpriteNode {
                increaseLevel = true
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        collisionBetween(object1: contact.bodyA.node!, object2: contact.bodyB.node!)
    }

    override func didMove(to view: SKView) {
        
        
        // For detecting collisions
        self.physicsWorld.contactDelegate = self
        
        if let shine = self.childNode(withName: "//Shine") as? SKSpriteNode {
            shine.position = CGPoint(x:317 ,y:840)
        }
        if let goal0 = self.childNode(withName: "//Goal1") as? SKSpriteNode {
            goal0.position = CGPoint(x:317 ,y:1119)
        }
       
        super.didMove(to: view)
        cam = SKCameraNode()
        self.camera = cam
        self.addChild(cam!)
        
        let zoomInAction = SKAction.scale(to:1.6, duration: 1)
        self.camera?.run(zoomInAction)
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
        
        //humanWalkingFramesForward = self.buildHuman(name:"human")
        //humanWalkingFramesBackward = self.buildHuman(name:"humanflip")
        humanWalkingFramesForward = self.buildHuman(name:"human")
        humanWalkingFramesBackward = self.buildHuman(name:"humanflip")
        yellowSquareBoxFrames = self.buildHuman(name:"shine")
        
        if let shineNode = self.childNode(withName: "//Shine") as? SKSpriteNode {
            shineNode.run(SKAction.repeatForever(
                SKAction.animate(with: yellowSquareBoxFrames,
                                 timePerFrame: 0.1,
                                 resize: false,
                                 restore: true)),
                          withKey:"shinePattern")
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        /*if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }*/
        if let brickNode = self.childNode(withName: "//Brick") as? SKSpriteNode {
            brickNode.position = pos
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
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
            case 0x31:
                if let label = self.label {
                    holdingUp = true
                    label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
 
                }
            case 124:
                holdingRight = true
            case 123:
                holdingLeft = true
            case 126:
                holdingUp = true
            case 9:
                run = true
            case 125:
                holdingDown = true
            case 15: // reset
                if let brickNode = self.childNode(withName: "//Brick") as? SKSpriteNode {
                    brickNode.position = CGPoint(x:0 ,y:100)
                }
            default:
                print("UNHANDLED keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    override func keyUp(with event: NSEvent) {
        switch event.keyCode {
            case 124:
                holdingRight = false
            moving = false
            case 123:
                holdingLeft = false
            moving = false
            case 126:
                holdingUp = false
            moving = false
            case 125:
                holdingDown = false
            moving = false
            case 9:
                run = false
            moving = false
            default:
                Void()
        }
    }
    
    enum WalkDirection {
        case None, Forward, Reverse
    }
    var walkDirection = WalkDirection.None
    
    func animateHumanStart(direction:WalkDirection) {
        if (walkDirection == direction) {
            // it's currently animating in the same direction, leave it alone
            return
        }
        
        self.walkDirection = direction
        
        let walkFrames: [SKTexture] = (direction == WalkDirection.Forward) ? humanWalkingFramesForward : humanWalkingFramesBackward
        
        if let brickNode = self.childNode(withName: "//Brick") as? SKSpriteNode {
            self.animateHumanStop()
            brickNode.run(SKAction.repeatForever(
                SKAction.animate(with:  walkFrames,
                                 timePerFrame: 0.1,
                                 resize: false,
                                 restore: true)),
                     withKey:"walkingInPlaceHuman")
        }
    }
    
    func animateHumanStop() {
        if let brickNode = self.childNode(withName: "//Brick") as? SKSpriteNode {
            brickNode.removeAction(forKey:"walkingInPlaceHuman")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        //vframe = vframe + 1
        //print("frame", vframe)
        
        let movement:CGFloat = 5.0;
        var movementw:CGFloat = 5.0;
        var movementu:CGFloat = 5.0;
        
        if let brickNode = self.childNode(withName: "//Brick") as? SKSpriteNode {
            super.update(currentTime)
            
            if (self.increaseLevel) {
                print(level)
                if level == 1 {
                print("Setting new position")
                brickNode.position = CGPoint(x:1840 ,y:1191)
                    if let goal0 = self.childNode(withName: "//Goal1") as? SKSpriteNode {
                        goal0.position = CGPoint(x:3471 ,y:1265)
                    }
                    if let shine = self.childNode(withName: "//Shine") as? SKSpriteNode {
                        shine.position = CGPoint(x:317 ,y:840)
                    }
                }
                if level == 2 {
                    print("Setting new position")
                    brickNode.position = CGPoint(x:4857 ,y:1211)
                    if let goal0 = self.childNode(withName: "//Goal1") as? SKSpriteNode {
                        goal0.position = CGPoint(x:4701 ,y:1578)
                    }
                    if let shine = self.childNode(withName: "//Shine") as? SKSpriteNode {
                        shine.position = CGPoint(x:4682 ,y:1477)
                    }
                }
                self.increaseLevel = false
            }
            
            camera?.position = brickNode.position
            if run == true {
                movementw = movementw + 5
                movementu = movementu + 2.5
            }
            
            if (!(holdingLeft || holdingRight)) {
                if(self.walkDirection != WalkDirection.None) {
                    self.animateHumanStop()
                    self.walkDirection = WalkDirection.None
                }
            }

            if holdingRight == true {
                moving = true
                facingLeft = false
                self.animateHumanStart(direction:WalkDirection.Forward)
                brickNode.texture = SKTexture(imageNamed: "human_1")
                brickNode.run(SKAction.moveBy(x: movementw, y: 0, duration: 0.01))
            }
            if holdingLeft == true {
                moving = true
                facingLeft = true
                self.animateHumanStart(direction:WalkDirection.Reverse)
                brickNode.texture = SKTexture(imageNamed: "humanflip_1")
                brickNode.run(SKAction.moveBy(x: -movementw, y: 0, duration: 0.01))
            }
            if holdingDown == true {
                brickNode.run(SKAction.moveBy(x: 0, y: -movement, duration: 0.01))
                moving = true
            }            
            if holdingUp == true {
                brickNode.run(SKAction.moveBy(x: 0, y: movementu + 8, duration: 0.01))
                moving = true
            }
        }
    }
}

