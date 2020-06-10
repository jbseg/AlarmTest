//
//  charitySelection.swift
//  AlarmTest
//
//  Created by Joshua Segal on 5/30/20.
//  Copyright © 2020 Joshua Segal. All rights reserved.
//

import SwiftUI

struct charitySelection: View {
    var body: some View {
        VStack{
            Text("Charities")
                .font(.largeTitle)
            ForEach(0..<2) {_ in
                HStack{
                    Text("Hi")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .frame(width: 100, height: 100)
                        .background(Color.red)
                    Text("Hi")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .frame(width: 100, height: 100)
                        .background(Color.red)
                }.padding()
                    
            }
        }
    }
}

struct charitySelection_Previews: PreviewProvider {
    static var previews: some View {
        charitySelection()
    }
}
