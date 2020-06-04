//
//  SignInView.swift
//  AlarmTest
//
//  Created by Joshua Segal on 6/3/20.
//  Copyright © 2020 Joshua Segal. All rights reserved.
//

import SwiftUI

struct SignInView : View {

    @State var email: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false

    @EnvironmentObject var session: SessionStore

    func signIn () {
        loading = true
        error = false
        session.signIn(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                print("failed login")
                self.error = true
            } else {
                print("logged in!")
            }
        }
    }

    var body: some View {
        VStack {
            TextField("email address", text: $email)
                .padding()
            SecureField("Password", text: $password)
                .padding()
            if (error) {
                Text("username or password is wrong").foregroundColor(.red)
            }
            Button(action: signIn) {
                Text("Sign in")
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
