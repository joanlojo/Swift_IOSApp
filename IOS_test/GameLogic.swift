//
//  GameLogic.swift
//  IOS_test
//
//  Created by joan lopez joaquin on 21/03/2019.
//  Copyright © 2019 joan lopez joaquin. All rights reserved.
//

import UIKit

enum Difficulty: Int{
    case easy = 12
    case medium = 20
    case hard = 30
}


class GameLogic {
    
    var points: Int
    var valuePoints = 50
    var combos: Int = 0
    var cards = [Card]()
    var time: TimeInterval = 0
    var maxTime: TimeInterval = 0
    var initTime: TimeInterval = 0
    var isFirstTime: Bool = false
    var cardSelected: Card?
    
    var isMatchReady: Bool?
    let difficulty: Int
    let namePathFront = ["pogba", "cr", "grizi", "rash", "messi", "ibra", "pique", "ramos", "bape", "rak", "ney"] //nombre de todas las caras
    let namePathBack = ["campo"]
    
    init (){
        //pasar la dificultad de alguna amnera
        self.points = 0
        self.difficulty = 0
    }
    //crear el array de cartas en funcion de la dificultad
    func getArrayofCards( difficulty: Difficulty) -> [Card]{
        cards = [Card]()
        let texturesPathFrontShuffled = namePathFront.shuffled()
        for i in 0..<difficulty.rawValue / 2{
            let textureNameFront = texturesPathFrontShuffled[i]
            let textureNameBack = namePathBack.randomElement()!
            let card1 = Card(ID: i, idPair: i,  texturePathFront: textureNameFront, texturePathBack: textureNameBack, state: Card.CardState.tapada)
            let card2 = Card(ID: i + difficulty.rawValue, idPair: i, texturePathFront: textureNameFront, texturePathBack: textureNameBack, state: Card.CardState.tapada)
            cards.append(card1)
            cards.append(card2)
        }
        return cards.shuffled()
    }
    
    func changeTime(difficulty: Difficulty){
        if difficulty == .easy{
            maxTime = 100
        }
        if difficulty == .medium{
            maxTime = 12
        }
        if difficulty == .hard{
            maxTime = 16
        }
    }
    
    //funcion para determinar si todas las cartas estan destapadas con exito --> has ganado el nivel
    func checkGameState(cards: [CardSprite]) -> Bool{
        for i in 0..<cards.count{
            if cards[i].card?.state != Card.CardState.match{
                //print("ganas")
                return false
            }
        }
        return true
    }
    
    func getFirstTime(time: TimeInterval){
        if !isFirstTime{
            initTime = time
            isFirstTime = true

        }
        
    }
    
    //funcion para detectar si las dos cartas que seleccionas son las mismas o no y cambiar si estado en funcion de ello
    func tryMatch(card: Card){
        card.state = Card.CardState.destapada
        if isMatchReady == true && card.state == Card.CardState.destapada && cardSelected?.state == Card.CardState.destapada{
            if let cardSelected = cardSelected{
                if cardSelected.idPair == card.idPair{
                    cardSelected.state = Card.CardState.match
                    card.state = Card.CardState.match
                    combos += 1
                    if combos >= 2{
                        valuePoints = combos * valuePoints
                    }
                    points += valuePoints
                    
                    print(valuePoints)
                    print(combos)

                    //return true
                }else{
                    combos = 0
                    valuePoints = 50
                    cardSelected.state = Card.CardState.tapada
                    card.state = Card.CardState.tapada
                }
                isMatchReady = false
            }
            
        }else{
            self.cardSelected = card
            self.cardSelected?.state = Card.CardState.destapada
            isMatchReady = true
        }
    }
    
    func reset(){
        
    }
    
    func update(){
        
    }
    
    func didWin() -> Bool{
        return false
    }
}
