//
//  UserManager.swift
//  mochilla
//
//  Created by Tomas Esber on 3/28/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBUser {
    let userId: String
    let dateCreated: Date?
    let email: String?
    let photoUrl: String?
}

final class UserManager {
    
    static let shared = UserManager()
    private init() {}
    
    func createNewUser(auth: AuthDataResultModel) async throws {
        // create a dictionary
        var userData: [String : Any] = [
            "user_id" : auth.uid,
            "date_created" : Timestamp(),
        ]
        
        if let email = auth.email {
            userData["email"] = email
        }
        
        if let photoUrl = auth.photoUrl {
            userData["photo_url"] = photoUrl
        }
        // setData overwrites the document
        // updateData adds field to the existing document (only use if document already exists)
        // set merge to false since there isn't an existing user document, so nothing to merge into
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
    }
    
    func getUser(userId: String) async throws -> DBUser {
        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
        
        guard let data = snapshot.data(), let userId = data["user_id"] as? String else {
            throw URLError(.badServerResponse)
        }
        
        let dateCreated = data["date_created"] as? Date
        let email = data["email"] as? String
        let photoUrl = data["photo_url"] as? String
        
        return DBUser(userId: userId, dateCreated: dateCreated, email: email, photoUrl: photoUrl)
    }
}
