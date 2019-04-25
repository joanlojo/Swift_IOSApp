//
//  FirestoreRepository.swift
//  IOS_test
//
//  Created by Programacion Moviles on 25/4/19.
//  Copyright © 2019 joan lopez joaquin. All rights reserved.
//

import Foundation
import FirebaseFirestore

class FirestoreRepository{
    
    func writeUserScore(){
        let db = Firestore.firestore()
        
        db.collection("scores").addDocument(data: ["score": 1])
    }
}
