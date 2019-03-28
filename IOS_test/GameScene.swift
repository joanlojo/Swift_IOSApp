//
//  GameEasy.swift
//  IOS_test
//
//  Created by joan lopez joaquin on 15/03/2019.
//  Copyright © 2019 joan lopez joaquin. All rights reserved.
//

import SpriteKit

protocol GameSceneDelegate: class {
    func back(sender: GameScene)
}

class GameScene: SKScene, ButtonDelegate {
    
    static let buttonWidth: CGFloat = 200.0
    static let buttonHeight: CGFloat = 50.0
    var gameMode: SKLabelNode!
    var cardSprite = [CardSprite]()
    
    weak var gameSceneDelegate: GameSceneDelegate?
    
    let gameLogic: GameLogic = GameLogic()
    private var label : SKLabelNode?
    
    private var backButton = Button(rect: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight), cornerRadius: 10)
    
    var difficulty: Difficulty?
    
    override func didMove(to view: SKView) {
        
        
        if difficulty == .easy{
            gameMode = SKLabelNode(fontNamed: "Futura")
            gameMode.text = "Easy"
            gameMode.fontColor = UIColor.black
            gameMode.fontSize = 20
            gameMode.position = CGPoint(x: view.frame.width / 7 - gameMode.frame.width/2, y: view.frame.height * 0.9)
            if let difficulty = difficulty{
                gameLogic.cards = gameLogic.getArrayofCards(difficulty: difficulty)
                createImageCard(view: view, cards: gameLogic.cards)
            }
            //addChild(<#T##node: SKNode##SKNode#>)
            //carta
            //createImageCard(view: view, cards: gameLogic.cards)
            
        }else if difficulty == .medium{
            gameMode = SKLabelNode(fontNamed: "Futura")
            gameMode.text = "Medium"
            gameMode.fontColor = UIColor.black
            gameMode.fontSize = 20
            gameMode.position = CGPoint(x: view.frame.width / 7 - gameMode.frame.width/2, y: view.frame.height * 0.9)
        }else if difficulty == .hard{
            gameMode = SKLabelNode(fontNamed: "Futura")
            gameMode.text = "Hard"
            gameMode.fontColor = UIColor.black
            gameMode.fontSize = 20
            gameMode.position = CGPoint(x: view.frame.width / 7 - gameMode.frame.width/2, y: view.frame.height * 0.9)
        }
        addChild(gameMode)
        
        backButton.setText(text: "BACK")
        backButton.fillColor = .red
        backButton.isUserInteractionEnabled = true
        backButton.delegate = self
        backButton.position = CGPoint(x: view.frame.width / 10.0 - backButton.frame.width/2, y: 100)
        addChild(backButton)
    }
    
    func createImageCard(view: SKView, cards: [Card]){
        for i in 0..<cards.count / 2{
            let sprite = CardSprite(size: CGSize(width: 10, height:10), textureFront: SKTexture(imageNamed: cards[i].texturePathFront), textureBack: SKTexture(imageNamed: cards[i].texturePathFront))
            
            sprite.position = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
            cardSprite.append(sprite)
            scene?.addChild(sprite)
        }
    }
    
    func onTap(sender: Button) {
        if sender == backButton {
            gameSceneDelegate?.back(sender: self)
        }
    }
    
}
