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
    
    var boxes = 10
    
    
    //Inventory item storage
    var inventory = ["box", "box", "box", "box", "box"]
    var buttons = [CustomSpriteNode]()
    
    var scoreLabel: SKLabelNode!
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    //For counting combination score for hitting many boxes
    var comboLabel: SKLabelNode!
    var combo: Int = 0 {
        didSet {
            comboLabel.text = "Combo: \(combo)"
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
        
        comboLabel = SKLabelNode(fontNamed: "ChalkDuster")
        comboLabel.text = "Combo: 0"
        comboLabel.horizontalAlignmentMode = .right
        comboLabel.position = CGPoint(x: 700, y: 700)
        addChild(comboLabel)
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
                if(editLabel.text == "Edit"){
                    //Create an inventory bar at the top of the screen
                    //makeInventory(at: CGPoint(x: 100, y:700))
                    
                    //Reset number of balls
                    balls = 5
                }
                else{
                    removeInventory()
                }
                editingMode = !editingMode
                
            } else {
                if editingMode {
        
                    //If you click on an object that is a box, remove it
                    if(touchedNode.name == "box"){
                        touchedNode.removeFromParent()
                        boxes += 1
                    }
                    
                    else{
                        if(location.y <= 650){
                            if(boxes > 0){
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
                            boxes -= 1
                            }
                        }
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
                        ball.physicsBody!.restitution = 0.5
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
            if(combo == 0){
                combo += 1
            }
            else {
                combo *= 2
            }
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
        score += combo
        combo = 0
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "ball" {
            collisionBetween(ball: contact.bodyA.node!, object: contact.bodyB.node!)
        } else if contact.bodyB.node?.name == "ball" {
            collisionBetween(ball: contact.bodyB.node!, object: contact.bodyA.node!)
        }
    }
    
    func makeInventory(at position: CGPoint) {
        // Create inventory navigation buttons
        let leftButton : CustomSpriteNode = CustomSpriteNode(color: SKColor.red, size: CGSize(width: 60, height: 44))
        let rightButton : CustomSpriteNode = CustomSpriteNode(color: SKColor.red, size: CGSize(width: 60, height: 44))
        
        // Place inventory navigation buttons
        leftButton.position = CGPoint(x: 200, y:720)
        rightButton.position = CGPoint(x:560, y:720)
        self.addChild(leftButton)
        self.addChild(rightButton)
        
        buttons.append(leftButton)
        buttons.append(rightButton)
        
        //Place items from the inventory item name array
        renderItems(num: 1)
    }
    
    
    //Creates buttons for each inventory item beginning at the number given
    func renderItems(num: Int){
        var posx = 260
        let posy = 720
        
        for index in 0...4 {
            var id = num + index
            if(id > 5) {
                id -= 5
            }
            let midButton : CustomSpriteNode = CustomSpriteNode(color: SKColor.blue, size: CGSize(width: 60, height: 44))
            midButton.id = id
            midButton.position = CGPoint(x: posx, y: posy)
            self.addChild(midButton)
            buttons.append(midButton)
            posx += 60
        }
    }
    
    func removeInventory() {
        for button in buttons {
            button.removeFromParent()
        }
    }
    
}

