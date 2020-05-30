//
//  RingingAnim.swift
//  AlarmTest
//
//  Created by Joshua Segal on 5/29/20.
//  Copyright © 2020 Joshua Segal. All rights reserved.
//

import SwiftUI

struct RingingAnim: View {
    var wakeUp: Date
    @EnvironmentObject var RT: RealTime
    var body: some View {
        VStack{
            if wakeUp <= RT.date {
                Image(systemName: "alarm.fill")
            }
            else {
                Image(systemName: "alarm")
            }
        }
    }
}

struct RingingAnim_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
//            Color.black.edgesIgnoringSafeArea(.all)
            RingingAnim(wakeUp: Date()).environmentObject(RealTime())
        }
    }
}
