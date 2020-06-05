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

var body: some View {
     VStack {
         Spacer()
         Spacer()
         Image(systemName: "alarm")
             .resizable()
             .aspectRatio(contentMode: .fit)
             .frame(width: 100, height: 100, alignment: .center)
         
         Spacer()
             
         VStack(alignment: .leading){
             VStack(alignment: .leading){
                 Text("Email")
                     .font(.headline)
                     .fontWeight(.light)
                     .foregroundColor(Color.init(.label)
                         .opacity(0.75))
                 TextField("Enter Your Email", text: $email)
                 Divider()
             }.padding(.bottom, 15)
             
             VStack(alignment: .leading){
                 Text("Password")
                     .font(.headline)
                     .fontWeight(.light)
                     .foregroundColor(Color.init(.label)
                         .opacity(0.75))
                 SecureField("Enter Your Password", text: $password)
                 Divider()
             }
             if (error) {
                 Text("username or password is wrong").foregroundColor(.red)
             }
             
             
         }
         .padding(.horizontal, 6)
         
         Button(action: signUp) {
             Text("Sign Up")
             .font(.system(size: 20))
                 .foregroundColor(.white)
             .padding(.horizontal, 60)
             .padding(.vertical, 15)
             .background(Color.blue)
             .cornerRadius(25)
             
         }
         .padding(.top, 20)
         .padding(.bottom, 10)
        NavigationLink(destination: SignInView()) {
            Text("already have an account? Sign in")
        }
        .foregroundColor(.blue)
         Spacer()
         Spacer()
     }
     .padding()
 }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(SessionStore())
    }
}

