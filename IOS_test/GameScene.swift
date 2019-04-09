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
    func gameToResult(sender: GameScene, points: Int)
}

class GameScene: SKScene, CardSpriteDelegate, ButtonDelegate{
    
    static let buttonWidth: CGFloat = 200.0
    static let buttonHeight: CGFloat = 50.0
    var gameMode: SKLabelNode!
    var cardSprite = [CardSprite]()
    
    var valuePoints: SKLabelNode!
    var timeLabel: SKLabelNode!
    var currentTime: TimeInterval?
    
    weak var gameSceneDelegate: GameSceneDelegate?
    
    let gameLogic: GameLogic = GameLogic()
    private var label : SKLabelNode?
    
    private var backButton : Button?
    var difficulty: Difficulty?
    
    override func didMove(to view: SKView) {
        //
        
        //seleccionar las cartas para pasarlas a la funcion para asignarle la imagen
        if let difficulty = difficulty{
            gameLogic.cards = gameLogic.getArrayofCards(difficulty: difficulty)
            createImageCard(view: view, cards: gameLogic.cards)
            //definir el tiempo de cada nivel
            gameLogic.changeTime(difficulty: difficulty)
        }
        
        timeLabel = SKLabelNode(fontNamed: "Futura")
        //if let time = gameLogic.time{
        timeLabel.text = "Time: 0 "
        //}
        timeLabel.fontColor = UIColor.black
        timeLabel.fontSize = 20
        timeLabel.position = CGPoint(x: 0.8 * (view.frame.width), y: view.frame.height - 100)
        self.addChild(timeLabel)
        
        //mostrar los puntos por pantalla
        valuePoints = SKLabelNode(fontNamed: "Futura")
        valuePoints.text = "Points: " + String(gameLogic.points)
        valuePoints.fontColor = UIColor.black
        valuePoints.fontSize = 20
        valuePoints.position = CGPoint(x: view.frame.width/2, y: view.frame.height - 100)
        self.addChild(valuePoints)
        
        
        if difficulty == .easy{
            gameMode = SKLabelNode(fontNamed: "Futura")
            gameMode.text = "Easy"
            gameMode.fontColor = UIColor.black
            gameMode.fontSize = 20
            gameMode.position = CGPoint(x: 0.3 * (view.frame.width / 2), y: view.frame.height * 0.9)
            
        }else if difficulty == .medium{
            gameMode = SKLabelNode(fontNamed: "Futura")
            gameMode.text = "Medium"
            gameMode.fontColor = UIColor.black
            gameMode.fontSize = 20
            gameMode.position = CGPoint(x: 0.3 * (view.frame.width / 2), y: view.frame.height * 0.9)
        }else if difficulty == .hard{
            gameMode = SKLabelNode(fontNamed: "Futura")
            gameMode.text = "Hard"
            gameMode.fontColor = UIColor.black
            gameMode.fontSize = 20
            gameMode.position = CGPoint(x: 0.3 * (view.frame.width / 2), y: view.frame.height * 0.9)
        }
        addChild(gameMode)
        
        //back button
        let buttonWidth = view.frame.width / 6
        let buttonHeight = buttonWidth / 2.0
        backButton = Button(rect: CGRect(x: 0, y: 0 , width: buttonWidth, height: buttonHeight), cornerRadius: 10)
        if let backButton = backButton{
            backButton.setImage(imageNamed: "back")
            backButton.fillColor = .clear
            backButton.strokeColor = .clear
            backButton.isUserInteractionEnabled = true
            backButton.delegate = self
            backButton.position = CGPoint(x: view.frame.width / 10.0 - backButton.frame.width/2, y: view.frame.height * 0.85)
            addChild(backButton)
        }
        
    }
    //asignar la imagen a la carta
    func createImageCard(view: SKView, cards: [Card]){
        for i in 0..<cards.count{
            let sprite = CardSprite(size: CGSize(width: 10, height:10), textureFront: SKTexture(imageNamed: cards[i].texturePathFront), textureBack: SKTexture(imageNamed: cards[i].texturePathBack))
            cardSprite.append(sprite)
            cardSprite[i].delegate = self
            cardSprite[i].card = cards[i]
        }
        setPositionCard(view: view)
    }
    
    //posicionar las cartas en funcion del grado de dificultad y la cantidad
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
    //funcion para volver al menu principal
    func onTap(sender: Button) {
        if sender == backButton{
            gameSceneDelegate?.back(sender: self)
        }
    }
    
    
    //enviar la carta para comprobar la logica y cambiar las texturas a corde con el estado de la carta
    func onTap(sender: CardSprite) {
        if let card = sender.card{
            if card.state != Card.CardState.destapada && card.state != Card.CardState.match{
                gameLogic.tryMatch(card: card)
                //if SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.run{
                if card.state == Card.CardState.destapada{
                    sender.changeTexture(texture: sender.textureFront)
                    for i in 0..<cardSprite.count{
                        if gameLogic.cardSelected?.ID == cardSprite[i].card?.ID{
                            if gameLogic.cardSelected?.state == Card.CardState.destapada{
                                cardSprite[i].changeTexture(texture: sender.textureFront)
                            }
                        }
                    }
                    
                }else if card.state == Card.CardState.tapada{
                    sender.changeTexture(texture: sender.textureBack)
                    for i in 0..<cardSprite.count{
                        if gameLogic.cardSelected?.ID == cardSprite[i].card?.ID{
                            if gameLogic.cardSelected?.state == Card.CardState.tapada{
                                cardSprite[i].changeTexture(texture: sender.textureBack)
                            }
                        }
                    }
                }
                // else{
                if card.state == Card.CardState.match{
                    //para que se actualizen los puntos durante la partida
                    valuePoints.text = "Points: " + String(gameLogic.points)
                    sender.changeTexture(texture: sender.textureFront)
                    for i in 0..<cardSprite.count{
                        if gameLogic.cardSelected?.ID == cardSprite[i].card?.ID{
                            if gameLogic.cardSelected?.state == Card.CardState.match{
                                cardSprite[i].changeTexture(texture: sender.textureFront)
                            }
                        }
                    }
                }
            }
        }
        //cargar la escena del final de la partida
        if gameLogic.checkGameState(cards: cardSprite){
            print("ganas")
            let wait = SKAction.wait(forDuration: 1)
            let sequence = SKAction.sequence([
                wait,
                SKAction.run {
                    self.gameSceneDelegate?.gameToResult(sender: self, points: self.gameLogic.points)
                }
                ])
            self.run(sequence)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        gameLogic.getFirstTime(time: currentTime)
        gameLogic.time = gameLogic.maxTime - (currentTime - gameLogic.initTime)
        timeLabel.text = "Time: " + String(Int(gameLogic.time))
        
        if Int(gameLogic.time) <= 0{
            let wait = SKAction.wait(forDuration: 1)
            let sequence = SKAction.sequence([
                wait,
                SKAction.run {
                    self.gameSceneDelegate?.gameToResult(sender: self, points: self.gameLogic.points)
                }
                ])
            self.run(sequence)
        }
    }
    
}
