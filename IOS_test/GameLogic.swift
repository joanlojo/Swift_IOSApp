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
    var carSelected: Card?
    let difficulty: Int
    let namePathFront = ["pogba"] //nombre de todas las caras
    let namePathBack = ["campo"]
    
    init (){
        //pasar la dificultad de alguna amnera
        self.points = 0
        self.difficulty = 0
    }
    
    func getArrayofCards(difficulty: Difficulty) -> [Card]{
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
    }
    
    func reset(){
       
    }
    
    func update(){
        
    }
    
    func didWin() -> Bool{
        return false
    }
}
