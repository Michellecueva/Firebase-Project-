//
//  FirestoreService.swift
//  Firebase-Proj
//
//  Created by Michelle Cueva on 11/25/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation
import FirebaseFirestore

fileprivate enum FireStoreCollections: String {
    case users
    case posts
}


class FirestoreService {
    static let manager = FirestoreService()
    
    private let db = Firestore.firestore()
    
    //MARK: AppUsers
    func createAppUser(user: AppUser, completion: @escaping (Result<(), Error>) -> ()) {
        var fields = user.fieldsDict
        fields["dateCreated"] = Date()
        db.collection(FireStoreCollections.users.rawValue).document(user.uid).setData(fields) { (error) in
            if let error = error {
                completion(.failure(error))
                print(error)
            }
            completion(.success(()))
        }
    }
    
    func updateCurrentUser(userName: String? = nil, photoURL: URL? = nil, completion: @escaping (Result<(), Error>) -> ()){
        guard let userId = FirebaseAuthService.manager.currentUser?.uid else {
            //MARK: TODO - handle can't get current user
            return
        }
        var updateFields = [String:Any]()
        
        if let user = userName {
            updateFields["userName"] = user
        }
        
        if let photo = photoURL {
            updateFields["photoURL"] = photo.absoluteString
        }
        
//        let docRef = db.collection("users").document(userId)
//
//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                print("Document data: \(dataDescription)")
//            } else {
//                print("Document does not exist")
//            }
//        }
        
        db.collection(FireStoreCollections.users.rawValue).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
       
        //PUT request
        db.collection(FireStoreCollections.users.rawValue).document(userId).updateData(updateFields) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
            
        }
    }
    
    //MARK: Posts
    
    func createPost(post: Post, completion: @escaping (Result<(), Error>) -> ()) {
           var fields = post.fieldsDict
           fields["dateCreated"] = Date()
           db.collection(FireStoreCollections.posts.rawValue).addDocument(data: fields) { (error) in
               if let error = error {
                   completion(.failure(error))
               } else {
                   completion(.success(()))
               }
           }
       }
       
       func getAllPosts(completion: @escaping (Result<[Post], Error>) -> ()) {
           let completionHandler: FIRQuerySnapshotBlock = {(snapshot, error) in
               if let error = error {
                   completion(.failure(error))
               } else {
                   let posts = snapshot?.documents.compactMap({ (snapshot) -> Post? in
                       let postID = snapshot.documentID
                       let post = Post(from: snapshot.data(), id: postID)
                       return post
                   })
                   completion(.success(posts ?? []))
               }
           }

           //type: Collection Reference
           let collection = db.collection(FireStoreCollections.posts.rawValue)
           //If i want to sort, or even to filter my collection, it's going to work with an instance of a different type - FIRQuery
           //collection + sort/filter settings.getDocuments
         
            let query = collection.order(by:"dateCreated", descending: true)
               query.getDocuments(completion: completionHandler)

       }
}
