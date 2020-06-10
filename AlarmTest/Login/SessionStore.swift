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


class User : ObservableObject {
//    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var uid: String?
    @Published var email: String?
    @Published var firstName: String?
    @Published var lastName: String?
    @Published var image : Data?
    var handle: AuthStateDidChangeListenerHandle?

    
    init () {
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
                            self.uid = user.uid
                            self.email = user.email!
                            self.firstName = document.get("firstName") as? String
                            self.lastName = document.get("lastName") as? String
                            self.image = document.get("image") as? Data
                        }
                    } else {
                        print("Can't find user in db")
                    }
                }
            }  else {
               self.uid = nil
               self.email = nil
               self.firstName = nil
               self.lastName = nil
               self.image = nil
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
                self.uid = nil
                self.email = nil
                self.firstName = nil
                self.lastName = nil
                self.image = nil
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
}
