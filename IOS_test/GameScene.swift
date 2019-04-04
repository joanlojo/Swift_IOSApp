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

class GameScene: SKScene, CardSpriteDelegate{
   
    static let buttonWidth: CGFloat = 200.0
    static let buttonHeight: CGFloat = 50.0
    var gameMode: SKLabelNode!
    var cardSprite = [CardSprite]()
    
    //let card = [Card]()
    
    weak var gameSceneDelegate: GameSceneDelegate?
    
    let gameLogic: GameLogic = GameLogic()
    private var label : SKLabelNode?
    
    private var backButton = Button(rect: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight), cornerRadius: 10)
    
    var difficulty: Difficulty?
    
    override func didMove(to view: SKView) {
        
        if let difficulty = difficulty{
            gameLogic.cards = gameLogic.getArrayofCards(difficulty: difficulty)
            createImageCard(view: view, cards: gameLogic.cards)
        }
        
        if difficulty == .easy{
            gameMode = SKLabelNode(fontNamed: "Futura")
            gameMode.text = "Easy"
            gameMode.fontColor = UIColor.black
            gameMode.fontSize = 20
            gameMode.position = CGPoint(x: view.frame.width / 7 - gameMode.frame.width/2, y: view.frame.height * 0.9)
            
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
        
        /*backButton.setText(text: "BACK")
        backButton.fillColor = .red
        backButton.isUserInteractionEnabled = true
        backButton.delegate = self
        backButton.position = CGPoint(x: view.frame.width / 10.0 - backButton.frame.width/2, y: 100)
        addChild(backButton)*/
    }
    
    func createImageCard(view: SKView, cards: [Card]){
        for i in 0..<cards.count{
            let sprite = CardSprite(size: CGSize(width: 10, height:10), textureFront: SKTexture(imageNamed: cards[i].texturePathFront), textureBack: SKTexture(imageNamed: cards[i].texturePathBack))
            cardSprite.append(sprite)
            cardSprite[i].delegate = self
            cardSprite[i].card = cards[i]
        }
        setPositionCard(view: view)
    }
    
    func setPositionCard(view: SKView){
        for i in 0..<cardSprite.count{
            if difficulty == .easy{
                if(i<4){
                    cardSprite[i].position = CGPoint(x: view.frame.width/6, y: (0.5 + CGFloat(i)) * view.frame.height / 5)
                }
                else if(i<8){
                    cardSprite[i].position = CGPoint(x: 3 * view.frame.width/6, y: (0.5 + CGFloat(i-4)) * view.frame.height / 5)
                }
                else if(i>=8){
                    cardSprite[i].position = CGPoint(x: 5 * view.frame.width/6, y: (0.5 + CGFloat(i-8)) * view.frame.height / 5)
                }
                cardSprite[i].setScale(10)
            }
            else if difficulty == .medium{
                if(i<5){
                    cardSprite[i].position = CGPoint(x: view.frame.width/8, y: (0.6 + CGFloat(i)) * view.frame.height / 6.5)
                }
                else if(i<10){
                    cardSprite[i].position = CGPoint(x: 3 * view.frame.width/8, y: (0.6 + CGFloat(i-5)) * view.frame.height /  6.5)
                }
                else if(i<15){
                    cardSprite[i].position = CGPoint(x: 5 * view.frame.width/8, y: (0.6 + CGFloat(i-10)) * view.frame.height /  6.5)
                }
                else if(i>=15){
                    cardSprite[i].position = CGPoint(x: 7 * view.frame.width/8, y: (0.6 + CGFloat(i-15)) * view.frame.height /  6.5)
                }
                cardSprite[i].setScale(8)
            }
            else if difficulty == .hard{
                if(i<6){
                    cardSprite[i].position = CGPoint(x: view.frame.width/10, y: (0.6 + CGFloat(i)) * view.frame.height / 7.8)
                }
                else if(i<12){
                    cardSprite[i].position = CGPoint(x: 3 * view.frame.width/10, y: (0.6 + CGFloat(i-6)) * view.frame.height /  7.8)
                }
                else if(i<18){
                    cardSprite[i].position = CGPoint(x: 5 * view.frame.width/10, y: (0.6 + CGFloat(i-12)) * view.frame.height /  7.8)
                }
                else if(i<24){
                    cardSprite[i].position = CGPoint(x: 7 * view.frame.width/10, y: (0.6 + CGFloat(i-18)) * view.frame.height /  7.8)
                }
                else if(i>=24){
                    cardSprite[i].position = CGPoint(x: 9 * view.frame.width/10, y: (0.6 + CGFloat(i-24)) * view.frame.height /  7.8)
                }
                cardSprite[i].setScale(6)
                
            }
            scene?.addChild(cardSprite[i])
        }
    }
    /*func onTap(sender: Button) {
        if sender == backButton {
            gameSceneDelegate?.back(sender: self)
        }
    }*/
    
    func onTap(sender: CardSprite) {
        if let difficulty = difficulty{
            if let card = sender.card{
                if !gameLogic.tryMatch(card: card, difficulty: difficulty){
                    if SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run{ in [self scene]
                        if card.state == 1{
                            sender.texture = sender.textureFront
                            for i in 0..<cardSprite.count{
                                if gameLogic.cardSelected?.ID == cardSprite[i].card?.ID{
                                    if gameLogic.cardSelected?.state == 1{
                                        cardSprite[i].texture = cardSprite[i].textureFront
                                    }
                                }
                            }
                            
                        }else if card.state == 0{
                            sender.texture = sender.textureBack
                            for i in 0..<cardSprite.count{
                                if gameLogic.cardSelected?.ID == cardSprite[i].card?.ID{
                                    if gameLogic.cardSelected?.state == 0{
                                        cardSprite[i].texture = cardSprite[i].textureBack
                                    }
                                }
                            }
                        }
                    }
                }
                else{
                    if card.state == 2{
                        sender.texture = sender.textureFront
                        for i in 0..<cardSprite.count{
                            if gameLogic.cardSelected?.ID == cardSprite[i].card?.ID{
                                if gameLogic.cardSelected?.state == 2{
                                    cardSprite[i].texture = cardSprite[i].textureFront
                                }
                            }
                        }
                }
            }
        }
        
    }
    
}

