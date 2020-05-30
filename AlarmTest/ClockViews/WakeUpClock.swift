//
//  WakeUpClock.swift
//  AlarmTest
//
//  Created by Joshua Segal on 5/29/20.
//  Copyright © 2020 Joshua Segal. All rights reserved.
//

import SwiftUI

struct WakeUpClock: View {
    var date: Date
    var body: some View {
        Text("Wake up \(timeString(date: date))")
            .font(.system(size: 20))
            .fontWeight(.regular)
            .foregroundColor(Color.white)
    }
    func timeString(date: Date) -> String {
         let formatter = DateFormatter()
         formatter.dateFormat = "h:mm a"
         let time = formatter.string(from: date)
         return time
    }
}

struct WakeUpClock_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black
                .edgesIgnoringSafeArea(.all)
            WakeUpClock(date: Date())
        }
    }
}
