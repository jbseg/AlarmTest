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
    
    func signOut () {
         print("hi")
         session.signOut()
     }
    var body: some View {
        VStack {
            Text("uid: \(session.session?.uid ?? "")")
            Text("email: \(session.session?.email ?? "")")
            Button(action: signOut, label: {
                Text("Log out")
            })
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile().environmentObject(SessionStore())
    }
}
