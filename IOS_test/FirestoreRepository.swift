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
    let k_COLLECTION_SCORES = "scores"
    
    func writeUserScore(score: Int, username: String?, userId: String){
        let db = Firestore.firestore()
        
        db.collection(k_COLLECTION_SCORES).addDocument(data: ["score": score, "username": username ?? "", "userId": userId])
    }
    
    func updateUserScore(score: Int, username: String?, userId: String){
        let db = Firestore.firestore()

        db.collection(k_COLLECTION_SCORES).document(userId).setData(["score": score, "username": username ?? "", "userId": userId], merge: true)
    }
    func getUsetScore(){
        let db = Firestore.firestore()
        
        db.collection(k_COLLECTION_SCORES).whereField("score", isGreaterThan: 0).getDocuments {( snapshot, error) in
            
            if let error = error{
                print(error)
                // do something
            } else{
                snapshot?.documents.forEach({ print($0.data())})

            }
        }
    }
    /*func deleteScores(){
        let db = Firestore.firestore()

       db.collection(k_COLLECTION_SCORES).whereField("score", isGreaterThan: 0).getDocuments {( snapshot, error) in
            snapshot?.documents
    }*/
}
