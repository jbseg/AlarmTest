//
//  joinMenu.swift
//  AlarmTest
//
//  Created by Joshua Segal on 5/30/20.
//  Copyright © 2020 Joshua Segal. All rights reserved.
//

import SwiftUI

struct joinMenu: View {
    @State var code = ""
    var body: some View {
        VStack{
            TextField("Enter Code", text: $code)
                .frame(width: 116.844)
            Button(action: {
                print("joined group")
            }) {
                Text("join")
            }
            
        }.padding()
        .background(Color.white)
        .cornerRadius(15)
    }
}

struct joinMenu_Previews: PreviewProvider {
    static var previews: some View {
        joinMenu()
    }
}
