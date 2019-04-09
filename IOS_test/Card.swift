//
//  Card.swift
//  IOS_test
//
//  Created by joan lopez joaquin on 21/03/2019.
//  Copyright © 2019 joan lopez joaquin. All rights reserved.
//

import UIKit

class Card{
    
    let ID: Int
    let idPair: Int
    let texturePathFront: String
    let texturePathBack: String
    
    var state: CardState
    
    enum CardState{
        case tapada
        case destapada
        case match
    }
    //inicializar la carta
    init (ID: Int, idPair: Int,  texturePathFront: String, texturePathBack: String, state: CardState){
        self.texturePathFront = texturePathFront
        self.texturePathBack = texturePathBack
        self.ID = ID
        self.idPair = idPair
        self.state = state
    }
    
}


