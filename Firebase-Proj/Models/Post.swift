//
//  Post.swift
//  Firebase-Proj
//
//  Created by Michelle Cueva on 11/25/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Post {
    let imageUrl: String
    let userName: String
    let id: String
    let dateCreated: Date?
    
    init(imageUrl: String, userName: String, creatorID: String, dateCreated: Date? = nil) {
        self.imageUrl = imageUrl
        self.userName = userName
        self.id = UUID().description
        self.dateCreated = dateCreated
    }
    
    init?(from dict: [String: Any], id: String) {
        guard let imageUrl = dict["imageUrl"] as? String,
            let userName = dict["userName"] as? String,
            let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue() else { return nil }
        
        self.imageUrl = imageUrl
        self.userName = userName
        self.id = id
        self.dateCreated = dateCreated
    }
    
    var fieldsDict: [String: Any] {
        return [
            "imageUrl": self.imageUrl,
            "userName": self.userName,
        ]
    }
}



