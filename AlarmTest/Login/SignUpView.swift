//
//  SignupView.swift
//  AlarmTest
//
//  Created by Joshua Segal on 6/3/20.
//  Copyright © 2020 Joshua Segal. All rights reserved.
//
import SwiftUI
import Firebase

struct SignUpView : View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var loading = false
    @State var error = false
    @State var error_msg = ""
    @State var showImagePicker = false
    @State var image : Data = .init(count: 0)
    
    @EnvironmentObject var session: SessionStore
    
    func signUp () {
        loading = true
        error = false
        // check if the image is too large
        if self.image.count > 1000000 {
            error = true
            self.error_msg = "image is too large"
            return
        }
        session.signUp(email: email, password: password, image: image) { (result, error) in
            self.loading = false
            if error != nil {
                print("failed login")
                self.error = true
                self.error_msg = "username or password is wrong"
            } else {
                // create the user in the db
                print("image bytes: \(self.image)")
                Firestore.firestore().collection("users").document(result!.user.uid).setData(["image": self.image]) { (err) in
                    if err != nil {
                        print("error uploading the image: \((err?.localizedDescription)!)")
                        return
                    }
                }
                print("logged in!")
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
            
            VStack(alignment: .center){
                if self.image.count != 0 {
                    Button(action: {
                        self.showImagePicker.toggle()
                    }) {
                        Image(uiImage: UIImage(data: self.image)!)
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 55, height: 55)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    }
                } else {
                    Button(action: {
                        self.showImagePicker.toggle()
                    }) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 55, height: 55)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                    }
                }
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
                    Text(self.error_msg).foregroundColor(.red)
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
        .sheet(isPresented: self.$showImagePicker, content: {
            ImagePicker(show: self.$showImagePicker, image: self.$image)
        })
            .padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView().environmentObject(SessionStore())
    }
}

