//
//  GameScene.swift
//  IOS_test
//
//  Created by joan lopez joaquin on 15/02/2019.
//  Copyright © 2019 joan lopez joaquin. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol MenuSceneDelegate: class {
    func goToGame(sender: MenuScene, difficulty: Difficulty)
    func goToAbout(sender: MenuScene)
    func goToSettings(sender: MenuScene)
}

class MenuScene: SKScene, ButtonDelegate {
    
    weak var menuSceneDelegate: MenuSceneDelegate?
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var logo : SKSpriteNode?
    var gameName: SKLabelNode!
    
    private var easy: Button?
    private var medium: Button?
    private var hard: Button?
    private var options: Button?
    
    override func didMove(to view: SKView) {
        
        let buttonWidth = view.frame.width / 1.8
        let buttonHeight = buttonWidth / 4.5
        
        self.backgroundColor = SKColor(named: "Fondo")!
        
        easy = Button(rect: CGRect(x:0,y:0,width:buttonWidth, height: buttonHeight), cornerRadius: buttonHeight / 2.0)
        medium = Button(rect: CGRect(x:0,y:0,width:buttonWidth, height: buttonHeight), cornerRadius: buttonHeight / 2.0)
        hard = Button(rect: CGRect(x:0,y:0,width:buttonWidth, height: buttonHeight), cornerRadius: buttonHeight / 2.0)
        options = Button(rect: CGRect(x:0,y:0,width:buttonWidth, height: buttonHeight), cornerRadius: buttonHeight / 2.0)
        
        gameName = SKLabelNode(fontNamed: "Futura")
        gameName.text = "Memory"
        gameName.fontColor = UIColor.black
        gameName.fontSize = 30
        gameName.position = CGPoint(x: view.frame.width/2, y: view.frame.height - 100)
        
        self.addChild(gameName)
        if let easy = easy{
            easy.fillColor = SKColor(named: "notPressed")!
            easy.highlightColor = SKColor(named: "pressed")!
            easy.strokeColor = .clear
            easy.highlightStroke = SKColor(red: 0.6 , green: 0.6, blue: 0.6, alpha: 0.5)
            easy.isUserInteractionEnabled = true
            easy.position = CGPoint(x:view.frame.width / 2.0 - easy.frame.width/2, y: view.frame.height / 2.0 - easy.frame.height/2)
            easy.delegate = self
            easy.setText(text: "Easy")
            addChild(easy)
        }
        
        if let medium = medium{
            medium.fillColor = SKColor(named: "notPressed")!
            medium.highlightColor = SKColor(named: "pressed")!
            medium.strokeColor = .clear
            medium.highlightStroke = SKColor(red: 0.6 , green: 0.6, blue: 0.6, alpha: 0.5)
            medium.isUserInteractionEnabled = true
            medium.position = CGPoint(x:view.frame.width / 2.0 - medium.frame.width/2, y: view.frame.height / 2.0 - medium.frame.height/2 - 100)
            medium.delegate = self
            medium.setText(text: "Medium")
            addChild(medium)
        }
        if let hard = hard{
            hard.fillColor = SKColor(named: "notPressed")!
            hard.strokeColor = .clear
            hard.highlightStroke = SKColor(red: 0.6 , green: 0.6, blue: 0.6, alpha: 0.5)
            hard.highlightColor = SKColor(named: "pressed")!
            hard.isUserInteractionEnabled = true
            hard.position = CGPoint(x:view.frame.width / 2.0 - hard.frame.width/2, y: view.frame.height / 2.0 - hard.frame.height/2 - 200)
            hard.delegate = self
            hard.setText(text: "Hard")
            addChild(hard)
        }
        
        if let options = options{
            options.highlightStroke = .clear
            options.highlightColor = .clear
            options.strokeColor = .clear
            options.isUserInteractionEnabled = true
            options.position = CGPoint(x:view.frame.width / 10.0 - options.frame.width/2, y: view.frame.height * 0.9)
            options.delegate = self
            options.optionsOriginal = "options"
            options.optionsPressed = "optionsPressed"
            options.setImage(imageNamed: options.optionsOriginal!)
            addChild(options)
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label { //hacer que algo se haga oequeño y grande al hacer click
            let pulse = SKAction.sequence([SKAction.scale(by: 0.5, duration: 0.25), SKAction.scale(by: 2.0, duration: 0.25)])
            label.run(pulse)
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    func onTap(sender: Button) {
        if sender == easy{
            //print("easy")
            if let menuSceneDelegate = menuSceneDelegate {
                menuSceneDelegate.goToGame(sender: self, difficulty: .easy)
            }
        }
        else if sender == medium{
            //print("medium")
            if let menuSceneDelegate = menuSceneDelegate {
                menuSceneDelegate.goToGame(sender: self, difficulty: .medium)
            }
        }
        else if sender == hard{
            // print("hard")
            if let menuSceneDelegate = menuSceneDelegate {
                menuSceneDelegate.goToGame(sender: self, difficulty: .hard)
            }
        }
        else if sender == options{
            print("options")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
