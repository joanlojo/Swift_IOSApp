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
    let texturePathFront: String
    let texturePathBack: String
    
    var state: Int
    
    enum CardState: Int{
        case tapada = 0
        case destapada = 1
        case match = 2
    }
    //init(){}
    init (ID: Int, texturePathFront: String, texturePathBack: String, state: Int){
        self.texturePathFront = texturePathFront
        self.texturePathBack = texturePathBack
        self.ID = ID
        self.state = state
    }
    
}

