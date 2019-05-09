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
//    public var datos = [String]()
    let k_COLLECTION_SCORES = "scores"
    
    func writeUserScore(score: Int, username: String?, userId: String){
        let db = Firestore.firestore()
        
        db.collection(k_COLLECTION_SCORES).addDocument(data: ["score": score, "username": username ?? "", "userId": userId])
    }
    
    func updateUserScore(score: Int, username: String?, userId: String){
        let db = Firestore.firestore()

        db.collection(k_COLLECTION_SCORES).document(userId).setData(["score": score, "username": username ?? "", "userId": userId], merge: true)
    }
    func getUsetScore(_ callback: @escaping (([String]?, Error?) -> Void)) {
        let db = Firestore.firestore()

        db.collection(k_COLLECTION_SCORES).whereField("score", isGreaterThan: 0).getDocuments {( snapshot, error) in
            
            if let error = error{
                print(error)
                //return ""
               // return false
                // do something
                callback(nil, error)
            } else{
                var datos = [String]()
                snapshot?.documents.forEach {
                    datos.append("\(String(describing: $0.data()["score"]!))")
                   // print($0.data()["score"]!)
                }
                callback(datos, nil)
            }
        }
    }
    /*func deleteScores(){
        let db = Firestore.firestore()

       db.collection(k_COLLECTION_SCORES).whereField("score", isGreaterThan: 0).getDocuments {( snapshot, error) in
            snapshot?.documents
    }*/
}
