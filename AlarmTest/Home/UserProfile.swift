//
//  UserProfile.swift
//  AlarmTest
//
//  Created by Joshua Segal on 6/3/20.
//  Copyright © 2020 Joshua Segal. All rights reserved.
//

import SwiftUI

struct UserProfile: View {
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        VStack {
            if session.user != nil {
                Image(uiImage: UIImage(data: session.user!.image)!)
                    .resizable()
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
                Text("uid: \(session.user!.uid)")
                Text("email: \(session.user!.email)")
            }
            Button(action: signOut, label: {
                Text("Log out")
            })
        }
    }
    
    func signOut () {
        if session.signOut() {
            print("successfully signed out")
        } else {
            print("failed to sign out")
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile().environmentObject(SessionStore())
    }
}
