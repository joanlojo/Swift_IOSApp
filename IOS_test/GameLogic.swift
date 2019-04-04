//
//  GameLogic.swift
//  IOS_test
//
//  Created by joan lopez joaquin on 21/03/2019.
//  Copyright © 2019 joan lopez joaquin. All rights reserved.
//

import UIKit

enum Difficulty: Int{
    case easy = 8
    case medium = 16
    case hard = 24
}


class GameLogic {
    
    var points: Int
    var cards = [Card]()
    var cardSelected: Card?
    var isMatchReady: Bool?
    let difficulty: Int
    let namePathFront = ["pogba", "pogba", "pogba", "pogba", "pogba", "pogba", "pogba", "pogba", "pogba", "pogba", "pogba"] //nombre de todas las caras
    let namePathBack = ["campo"]
    
    init (){
        //pasar la dificultad de alguna amnera
        self.points = 0
        self.difficulty = 0
    }
    
    /*func getArrayofCards(difficulty: Difficulty) -> [Card]{
        cards = [Card]()
        let textureNameFront = namePathFront.randomElement()!
        let textureNameBack = namePathBack.randomElement()!
        for i in 0..<difficulty.rawValue / 2{
            let card1 = Card(ID: i, texturePathFront: textureNameFront, texturePathBack: textureNameBack, state: 0)
            let card2 = Card(ID: i + difficulty.rawValue / 2, texturePathFront: textureNameFront, texturePathBack: textureNameBack, state: 0)
            cards.append(card1)
            cards.append(card2)
        }
        return cards.shuffled()
    }*/
    func getArrayofCards( difficulty: Difficulty) -> [Card]{
        cards = [Card]()
        let texturesPathFrontShuffled = namePathFront.shuffled()
        for i in 0..<difficulty.rawValue / 2{
            let textureNameFront = texturesPathFrontShuffled[i]
            let textureNameBack = namePathBack.randomElement()!
            let card1 = Card(ID: i, texturePathFront: textureNameFront, texturePathBack: textureNameBack, state: 0)
            let card2 = Card(ID: i + difficulty.rawValue / 2, texturePathFront: textureNameFront, texturePathBack: textureNameBack, state: 0)
            cards.append(card1)
            cards.append(card2)
        }
        return cards.shuffled()
    }
    func changeState(){
        
    }
    
    func tryMatch(card: Card, difficulty: Difficulty) -> Bool{
        if card.state == 1{
            card.state = 0
            //cardSelected = card
            //cardSprite.texture = cardSprite.textureFront
        }else if card.state == 0{
            card.state = 1
            //cardSprite.texture = cardSprite.textureBack
        }
        if isMatchReady == true{
            if let cardSelected = cardSelected{
                if card.state == 1 && cardSelected.state == 1{
                    if cardSelected.ID == abs(card.ID - difficulty.rawValue / 2) {
                        cardSelected.state = 2
                        card.state = 2
                        print("match")
                        return true
                    }else{
                        cardSelected.state = 0
                        card.state = 0
                    }
                }
                print(abs(card.ID - difficulty.rawValue / 2))
                print(cardSelected.ID)
            }
            isMatchReady = false
        }else{
            cardSelected = card
            isMatchReady = true
        }
         return false
    }
    
    func reset(){
       
    }
    
    func update(){
        
    }
    
    func didWin() -> Bool{
        return false
    }
}
