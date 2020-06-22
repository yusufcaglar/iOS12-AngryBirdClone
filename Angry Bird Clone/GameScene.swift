//
//  GameScene.swift
//  Angry Bird Clone
//
//  Created by Yusuf ÇAĞLAR on 30/10/2018.
//  Copyright © 2018 Yusuf ÇAĞLAR. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var bird = SKSpriteNode()
    var background = SKSpriteNode()
    var tree = SKSpriteNode()
    var box = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    var gameStarted = false
    var originalPosition : CGPoint!
    var score = 0
    var scoreLabel = SKLabelNode()
    
    enum ColliderType: UInt32 {
        case Bird = 1
        case Box = 2
    }
    
    override func didMove(to view: SKView) {
        
        // Physics Body
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        // Delegate
        physicsWorld.contactDelegate = self
        
        // Bird
        
        let texture = SKTexture(imageNamed: "bird.png")
        bird = SKSpriteNode(texture: texture)
        bird.size = CGSize(width: self.frame.width / 14, height: self.frame.width / 12)
        bird.position = CGPoint(x: -420, y: -45)
        bird.zPosition = 2
        self.addChild(bird)
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: texture.size().height / 10)
        
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.mass = 0.1
        bird.physicsBody?.affectedByGravity = false
        
        originalPosition = bird.position
        
        bird.physicsBody?.contactTestBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.collisionBitMask = ColliderType.Box.rawValue
        
        // Background
        
        let backgroundTexture = SKTexture(imageNamed: "background.png")
        background = SKSpriteNode(texture: backgroundTexture)
        background.size = CGSize(width: self.frame.width, height: self.frame.height)
        background.position = CGPoint(x: 0, y: 0)
        background.zPosition = 0
        self.addChild(background)
        
        // Tree
        
        let treeTexture = SKTexture(imageNamed: "tree.png")
        tree = SKSpriteNode(texture: treeTexture)
        tree.size = CGSize(width: self.frame.width / 5, height: self.frame.height / 3)
        tree.position = CGPoint(x: -400, y: -148)
        tree.zPosition = 1
        self.addChild(tree)
        
        // Boxes
        
        let boxTexture = SKTexture(imageNamed: "box.png")
        box = SKSpriteNode(texture: boxTexture)
        box.size = CGSize(width: boxTexture.size().width / 5, height: boxTexture.size().height / 5)
        box.position = CGPoint(x: 300, y: 0)
        box.zPosition = 2
        box.physicsBody?.isDynamic = true
        box.physicsBody?.affectedByGravity = true
        box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
        box.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        self.addChild(box)
        
        let boxTexture2 = SKTexture(imageNamed: "box.png")
        box2 = SKSpriteNode(texture: boxTexture2)
        box2.size = CGSize(width: boxTexture2.size().width / 5, height: boxTexture2.size().height / 5)
        box2.position = CGPoint(x: 250, y: -100)
        box2.zPosition = 2
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.affectedByGravity = true
        box2.physicsBody = SKPhysicsBody(rectangleOf: box2.size)
        box2.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        self.addChild(box2)
        
        let boxTexture3 = SKTexture(imageNamed: "box.png")
        box3 = SKSpriteNode(texture: boxTexture3)
        box3.size = CGSize(width: boxTexture3.size().width / 5, height: boxTexture3.size().height / 5)
        box3.position = CGPoint(x: 200, y: -200)
        box3.zPosition = 2
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.affectedByGravity = true
        box3.physicsBody = SKPhysicsBody(rectangleOf: box3.size)
        box3.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        self.addChild(box3)
        
        let boxTexture4 = SKTexture(imageNamed: "box.png")
        box4 = SKSpriteNode(texture: boxTexture4)
        box4.size = CGSize(width: boxTexture3.size().width / 5, height: boxTexture4.size().height / 5)
        box4.position = CGPoint(x: 350, y: -100)
        box4.zPosition = 2
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody = SKPhysicsBody(rectangleOf: box4.size)
        box4.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        self.addChild(box4)
        
        let boxTexture5 = SKTexture(imageNamed: "box.png")
        box5 = SKSpriteNode(texture: boxTexture5)
        box5.size = CGSize(width: boxTexture5.size().width / 5, height: boxTexture5.size().height / 5)
        box5.position = CGPoint(x: 400, y: -200)
        box5.zPosition = 2
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.affectedByGravity = true
        box5.physicsBody = SKPhysicsBody(rectangleOf: box5.size)
        box5.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        self.addChild(box5)
        
        // Score
        
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 53
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 4)
        scoreLabel.zPosition = 3
        self.addChild(scoreLabel)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue || contact.bodyB.collisionBitMask == ColliderType.Bird.rawValue {
            
            score = score + 1
            scoreLabel.text = String(score)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        if gameStarted == false {
            
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        if gameStarted == false {
            
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false {
            
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            
                            if sprite == bird {
                                
                                let dx = -(touchLocation.x - originalPosition.x)
                                let dy = -(touchLocation.y - originalPosition.y)
                                
                                let impulse = CGVector(dx: dx, dy: dy)
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.affectedByGravity = true
                                gameStarted = true
                                
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if let birdPhysicsBody = bird.physicsBody {
            
           if birdPhysicsBody.velocity.dx <= 0.1 {
            if birdPhysicsBody.velocity.dy <= 0.1 {
                if birdPhysicsBody.angularVelocity <= 0.1 {
                    if gameStarted == true {
                        self.bird.physicsBody?.affectedByGravity = false
                        self.bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                        self.bird.physicsBody?.angularVelocity = 0
                        self.bird.position = self.originalPosition
                        self.score = 0
                        self.scoreLabel.text = "\(score)"
                        self.gameStarted = false
                    }
                }
            }
            
            }

            

            
        
        
            }
        }
    }


