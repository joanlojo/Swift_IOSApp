//
//  GameEasy.swift
//  IOS_test
//
//  Created by joan lopez joaquin on 15/03/2019.
//  Copyright © 2019 joan lopez joaquin. All rights reserved.
//

import SpriteKit
import FirebaseAnalytics
//import GoogleMobileAds

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
    var comboLabel: SKLabelNode!
    var currentTime: TimeInterval?
    
    weak var gameSceneDelegate: GameSceneDelegate?
    
    let gameLogic: GameLogic = GameLogic()
    private var label : SKLabelNode?
    
    private var backButton : Button?
    var difficulty: Difficulty?
    
    override func didMove(to view: SKView) {
     
        
        //seleccionar las cartas para pasarlas a la funcion para asignarle la imagen
        if let difficulty = difficulty{
            gameLogic.cards = gameLogic.getArrayofCards(difficulty: difficulty)
            createImageCard(view: view, cards: gameLogic.cards)
            //definir el tiempo de cada nivel
            gameLogic.changeTime(difficulty: difficulty)
        }
        
        for i in 0..<cardSprite.count{
            let wait = SKAction.wait(forDuration: 2)
            let sequence = SKAction.sequence([
                wait,
                SKAction.run {
                    self.cardSprite[i].card?.state = Card.CardState.tapada
                    self.cardSprite[i].changeTexture(texture: self.cardSprite[i].textureBack)
                }
                ])
            self.run(sequence)
            //cardSprite[i].card?.state = Card.CardState.tapada
            //cardSprite[i].changeTexture(texture: cardSprite[i].textureBack)
        }
        
        //inicializar el mensaje de combo
        comboLabel = SKLabelNode(fontNamed: "Futura")
        //comboLabel.text = "Combo: 0 "
        comboLabel.fontColor = UIColor.red
        comboLabel.fontSize = 20
        comboLabel.position = CGPoint(x: view.frame.width / 2, y: view.frame.height * 0.8)
        self.addChild(comboLabel)
        
        //inicializar el mensaje de tiempo para mostarlo
        timeLabel = SKLabelNode(fontNamed: "Futura")
        timeLabel.text = "Time: 0 "
        timeLabel.fontColor = UIColor.black
        timeLabel.fontSize = 20
        timeLabel.position = CGPoint(x: 0.8 * (view.frame.width), y: view.frame.height * 0.85)
        self.addChild(timeLabel)
        
        //mostrar los puntos por pantalla
        valuePoints = SKLabelNode(fontNamed: "Futura")
        valuePoints.text = "Points: " + String(gameLogic.points)
        valuePoints.fontColor = UIColor.black
        valuePoints.fontSize = 20
        valuePoints.position = CGPoint(x: view.frame.width/2, y: view.frame.height * 0.85)
        self.addChild(valuePoints)
        
        if difficulty == .easy{
            gameMode = SKLabelNode(fontNamed: "Futura")
            gameMode.text =  NSLocalizedString("EASY", comment: "")
            gameMode.fontColor = UIColor.black
            gameMode.fontSize = 20
            gameMode.position = CGPoint(x: 0.4 * (view.frame.width / 2), y: view.frame.height * 0.85)
            
        }else if difficulty == .medium{
            gameMode = SKLabelNode(fontNamed: "Futura")
            gameMode.text = NSLocalizedString("MEDIUM", comment: "")
            gameMode.fontColor = UIColor.black
            gameMode.fontSize = 20
            gameMode.position = CGPoint(x: 0.4 * (view.frame.width / 2), y: view.frame.height * 0.85)
        }else if difficulty == .hard{
            gameMode = SKLabelNode(fontNamed: "Futura")
            gameMode.text = NSLocalizedString("HARD", comment: "")
            gameMode.fontColor = UIColor.black
            gameMode.fontSize = 20
            gameMode.position = CGPoint(x: 0.4 * (view.frame.width / 2), y: view.frame.height * 0.85)
        }
        addChild(gameMode)
        
        //back button
        let buttonWidth = view.frame.width / 6
        let buttonHeight = buttonWidth / 2.0
        backButton = Button(rect: CGRect(x: 0, y: 0 , width: buttonWidth, height: buttonHeight), cornerRadius: 10)
        if let backButton = backButton{
            backButton.setImage(imageNamed: "back", scale: 0.07)
            backButton.fillColor = .clear
            backButton.strokeColor = .clear
            backButton.isUserInteractionEnabled = true
            backButton.delegate = self
            backButton.position = CGPoint(x: view.frame.width / 9.0 - backButton.frame.width/2, y: view.frame.height * 0.9)
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
                cardSprite[i].size = CGSize(width: view.frame.width / 3.5, height: view.frame.width / 3.5)
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
                cardSprite[i].size = CGSize(width: view.frame.width / 4.5 , height: view.frame.width / 4.5 )
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
                cardSprite[i].size = CGSize(width: view.frame.width / 5, height: view.frame.width / 5)
                
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
    
   // func goToNextLevel(){
       // Analytics.logEvent("nextlevel", parameters: [:]) //cuando te pasas un nivel de dificultad
    //}
    
    //enviar la carta para comprobar la logica y cambiar las texturas a corde con el estado de la carta
    func onTap(sender: CardSprite) {
        if let card = sender.card{
            if card.state != Card.CardState.destapada && card.state != Card.CardState.match && card.state == Card.CardState.tapada{
                //cualquier carta que seleccionas la giras
                card.state = Card.CardState.destapada
                sender.changeTexture(texture: sender.textureFront)
                //envias la carta que tocas
             
                //secuencia para la animacion de la carta
                let wait = SKAction.wait(forDuration: 0.4)
                let sequence = SKAction.sequence([
                    wait,
                    SKAction.run {
                        self.gameLogic.tryMatch(card: card)
                         if card.state == Card.CardState.tapada{
                            sender.changeTexture(texture: sender.textureBack)
                            if !AudioController.shared.soundPressed{
                                self.run(SKAction.playSoundFileNamed("Match_Incorrect.wav", waitForCompletion: false))
                            }else{
                                SKAction.wait(forDuration: 0.0)
                            }
                            for i in 0..<self.cardSprite.count{
                                if self.gameLogic.cardSelected?.ID == self.cardSprite[i].card?.ID{
                                    if self.gameLogic.cardSelected?.state == Card.CardState.tapada{
                                        self.cardSprite[i].changeTexture(texture: sender.textureBack)
                                    }
                                }
                            }
                            self.comboLabel.text = ""
                        }
                        if card.state == Card.CardState.match{
                            if !AudioController.shared.soundPressed{
                                self.run(SKAction.playSoundFileNamed("Match_Correct.wav", waitForCompletion: false))
                            }else{
                                SKAction.wait(forDuration: 0.0)
                            }
                            //para que se actualizen los puntos durante la partida
                            self.valuePoints.text = "Points: " + String(self.gameLogic.points)
                            if self.gameLogic.combos >= 2{
                                self.comboLabel.text = "Combo x" + String(self.gameLogic.combos)
                                if !AudioController.shared.soundPressed{
                                    self.run(SKAction.playSoundFileNamed("Combo.wav", waitForCompletion: false))
                                }else{
                                    SKAction.wait(forDuration: 0.0)
                                }

                            }
                        }
                    }
                    ])
                self.run(sequence)              
            }
        }
        //cargar la escena del final de la partida
        if gameLogic.checkGameState(cards: cardSprite){
            print("ganas")
            let wait = SKAction.wait(forDuration: 1)
            let sequence = SKAction.sequence([
                wait,
                SKAction.run {
                    Analytics.logEvent("levelPassed", parameters: [:]) //cuando te pasas un nivel de dificultad
                    self.gameSceneDelegate?.gameToResult(sender: self, points: self.gameLogic.points)
                }
                ])
            self.run(sequence)
        }
    }

    
    override func update(_ currentTime: TimeInterval) {
   
        //calcular el cuenta atras del tiempo de la partida y mostrarlo
        gameLogic.getFirstTime(time: currentTime)
        gameLogic.time = gameLogic.maxTime - (currentTime - gameLogic.initTime)
        timeLabel.text = "Time: " + String(Int(gameLogic.time))
        
        //acabas la partida pero no la ganas
        if Int(gameLogic.time) <= 0{
            let wait = SKAction.wait(forDuration: 1)
            let sequence = SKAction.sequence([
                wait,
                SKAction.run {
                    Analytics.logEvent("levelPassed", parameters: [:]) //cuando te pasas un nivel de dificultad
                    self.gameSceneDelegate?.gameToResult(sender: self, points: self.gameLogic.points)
                }
                ])
            self.run(sequence)
        }
    }
    
}
