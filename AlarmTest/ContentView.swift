//
//  ContentView.swift
//  FirebaseAuthTest
//
//  Created by Joshua Segal on 5/27/20.
//  Copyright © 2020 Joshua Segal. All rights reserved.
//

import SwiftUI
import Firebase

struct ContentView : View {
    
    @EnvironmentObject var session: SessionStore
    let firstLaunch = FirstLaunch()
    
    var body: some View {
        VStack {
            if Auth.auth().currentUser != nil {
                if firstLaunch.isFirstLaunch {
                    Tutorial()
                } else{
                    Home().transition(.slide)
                }
            } else {
                Login().transition(.slide)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SessionStore())
    }
}
