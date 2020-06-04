//
//  page.swift
//  AlarmTest
//
//  Created by Joshua Segal on 6/4/20.
//  Copyright © 2020 Joshua Segal. All rights reserved.
//

import SwiftUI
import Pages

struct Summary: View {
    @State var index: Int = 0
    @EnvironmentObject var firstLaunch: FirstLaunch
    
    var body: some View {
        Pages(currentPage: $index) {
            Text("This page will only be \n available for the first launch")
                
            
            Text("If you'd like to see it again\n delete and reinstall the app")
            Text("This is alarm roulette")
            Button(action: {self.firstLaunch.firstLaunchComplete()}) {
                Text("Tap here to Start!")
                     .padding()
                    .background(Color.blue)
               
                .cornerRadius(25)
            }
        }
            .multilineTextAlignment(.center)
            .background(Color.black)
        .foregroundColor(.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct Summary_Previews: PreviewProvider {
    static var previews: some View {
        Summary()
    }
}
