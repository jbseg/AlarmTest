//
//  SignupView.swift
//  AlarmTest
//
//  Created by Joshua Segal on 6/3/20.
//  Copyright © 2020 Joshua Segal. All rights reserved.
//
import SwiftUI

struct SignUpView : View {

    @State var email: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false

    @EnvironmentObject var session: SessionStore

    func signUp () {
        loading = true
        error = false
        session.signUp(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                print("failed login")
                self.error = true
            } else {
                print("logged in!")
//                print(result)
                self.email = ""
                self.password = ""
//                session.session = User
            }
        }
    }

//    func getUser () {
//        print("hi")
//        session.listen()
//    }
    
    var body: some View {
        VStack {
            TextField("email address", text: $email)
                .padding([.leading])
            SecureField("Password", text: $password)
                .padding([.leading])
//            TextField($email, placeholder: "email address")
//            SecureField($password, placeholder: Text("Password"))
            if (error) {
                Text("username or password is wrong").foregroundColor(.red)
            }
            Button(action: signUp) {
                Text("Sign up")
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(SessionStore())
    }
}

