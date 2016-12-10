//
//  GameScene.swift
//  project11
//
//  Created by Jay Steingold on 11/26/16.
//  Copyright © 2016 Jay Steingold. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    //Number of balls available
    var balls = 5
    
    var scoreLabel: SKLabelNode!
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var editLabel: SKLabelNode!
    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }
    
    //Equivalent of viewDidLoad method
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background.jpg")
        background.position = CGPoint(x: 512, y: 384)
        //Place in x, y coordinate space
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        //Adds physics to the game
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        //Add ability for objects to contact
        physicsWorld.contactDelegate = self
        
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
        
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
    }
    
    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        
        bouncer.physicsBody!.contactTestBitMask = bouncer.physicsBody!.collisionBitMask
        
        bouncer.physicsBody!.isDynamic = false //Can collide, but won't move
        addChild(bouncer)
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody!.isDynamic = false
        
        slotBase.position = position
        slotGlow.position = position
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: CGFloat.pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let objects = nodes(at: location) //For multiple nodes possible
            let touchedNode = self.atPoint(location) //For only one
            
            if objects.contains(editLabel) {
                editingMode = !editingMode
                //Reset number of balls
                balls = 5
            } else {
                if editingMode {
                    //If you click on an object that is a box, remove it
                    if(touchedNode.name == "box"){
                        touchedNode.removeFromParent()
                    }
                    
                    else{
                        //Create a box
                        let size = CGSize(width: GKRandomDistribution(lowestValue: 16, highestValue: 128).nextInt(), height: 16)
                        let box = SKSpriteNode(color: RandomColor(), size: size)
                        box.name = "box"
                        box.zRotation = RandomCGFloat(min: 0, max: 3)
                        box.position = location
                        
                        box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                        //Box doesn't move when hit
                        box.physicsBody!.isDynamic = false
                        addChild(box)
                    }
                    
                } else {
                    //Condition to restrict ball creation to top of the screen
                    if(location.y > 650 && balls > 0){
                        //Generate a random number and create a ball of a different color
                        let ballNum = Int(arc4random_uniform(7) + 1)
                        var ballName = ""
                        
                        switch(ballNum) {
                        case 1:
                            ballName = "ballBlue"
                        case 2:
                            ballName = "ballCyan"
                        case 3:
                            ballName = "ballGreen"
                        case 4:
                            ballName = "ballGrey"
                        case 5:
                            ballName = "ballPurple"
                        case 6:
                            ballName = "ballRed"
                        case 7:
                            ballName = "ballYellow"
                        default:
                            ballName = "ballBlue"
                        }
                        
                        //Create a ball
                        let ball = SKSpriteNode(imageNamed: ballName)
                        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
                        
                        //Set ball's detection to its collision
                        ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
                        //restituion = bounciness
                        ball.physicsBody!.restitution = 0.4
                        ball.position = location
                        ball.name = "ball"
                        addChild(ball)
                        balls -= 1
                    }
                }
            }
        }
    }
    
    func collisionBetween(ball: SKNode, object: SKNode) {
        //Destroy boxes after they are touched
        if object.name == "box" {
            object.removeFromParent()
        } else if object.name == "good" {
            destroy(ball: ball)
            score += 1
            balls += 1
        } else if object.name == "bad" {
            destroy(ball: ball)
            score -= 1
        }
    }
    
    func destroy(ball: SKNode) {
        //EmitterNode creates particle effects
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        //Removes the node from the game
        ball.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "ball" {
            collisionBetween(ball: contact.bodyA.node!, object: contact.bodyB.node!)
        } else if contact.bodyB.node?.name == "ball" {
            collisionBetween(ball: contact.bodyB.node!, object: contact.bodyA.node!)
        }
    }
    
}
