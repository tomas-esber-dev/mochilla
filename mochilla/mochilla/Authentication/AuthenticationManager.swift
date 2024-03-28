//
//  AuthenticationManager.swift
//  mochilla
//
//  Created by Tomas Esber on 3/28/24.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

// Singleton Design Patterns
// https://www.oodesign.com/singleton-pattern
final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() {}
    
    // get existing authenticated user from firebase
    // looking locally for the user (doesn't use async, no API call)
    // users are being saved in the SDK locally
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
    // create a user and store it in firebase
    // reaching out to the server (so we need async)
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    // signs us out locally (doesn't need to ping the server)
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
