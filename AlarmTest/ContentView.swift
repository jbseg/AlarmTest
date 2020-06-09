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
    
//    var session = SessionStore()
    @EnvironmentObject var firstLaunch: FirstLaunch
    @EnvironmentObject var user: User
    
    var body: some View {
        VStack {
            if !firstLaunch.wasLaunchedBefore {
                Welcome()
            }
            else if user.uid != nil {
                Home()
                 
                    .transition(.slide)
                
            } else {
                Login()
                    
                    .transition(.slide)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
           .environmentObject(FirstLaunch())
    }
}
