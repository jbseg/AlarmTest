//
//  SessionStore.swift
//  AlarmTest
//
//  Created by Joshua Segal on 6/3/20.
//  Copyright © 2020 Joshua Segal. All rights reserved.
//

import SwiftUI
import Firebase
import Combine

class User {
    var uid: String
    var email: String
    var firstName: String
    var lastName: String
    var image : Data
    init(uid: String, email: String, firstName: String, lastName: String, image : Data) {
        self.uid = uid
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.image = image
    }

}

class SessionStore : ObservableObject {
//    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var user: User?
    var handle: AuthStateDidChangeListenerHandle?

    
    func listen () {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // find the user in the db and load the info
                let docRef = Firestore.firestore().collection("users").document(user.uid)
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
//                        let image: Data = document.get("image") as! Data
                        withAnimation(.easeInOut(duration: 0.5)) {
                            // set the "user" environment variable
                            self.user = User(
                                uid: user.uid,
                                email: user.email!,
                                firstName: document.get("firstName") as! String,
                                lastName: document.get("lastName") as! String,
                                image: document.get("image") as! Data
                            )
                        }
                    } else {
                        print("Can't find user in db")
                    }
                }
            } else {
                self.user = nil
            }
        }
    }
    func signUp(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }

    func signIn(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }

    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            print("signing out")
            withAnimation(.easeInOut(duration: 0.5)) {
                self.user = nil
            }
            return true
        } catch {
            return false
        }
    }
    
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }

    // additional methods (sign up, sign in) will go here
}
