//
//  GameScene.swift
//  project11
//
//  Created by Jay Steingold on 11/26/16.
//  Copyright © 2016 Jay Steingold. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
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
            let ball = SKSpriteNode(imageNamed: "ballred")
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
            
            //Set ball's detection to its collision
            ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
            //restituion = bounciness
            ball.physicsBody!.restitution = 0.4
            ball.position = location
            ball.name = "ball"
            addChild(ball)
        }
    }
    
    func collisionBetween(ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroy(ball: ball)
        } else if object.name == "bad" {
            destroy(ball: ball)
        }
    }
    
    func destroy(ball: SKNode) {
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
