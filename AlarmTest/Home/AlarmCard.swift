//
//  AlarmCard.swift
//  AlarmTest
//
//  Created by Joshua Segal on 6/12/20.
//  Copyright © 2020 Joshua Segal. All rights reserved.
//

import SwiftUI

class AlarmInfo {
    var time: DateComponents
    var days_of_the_week: Array<Bool>
    var name: String
    var charity: String
    var donation: Float
    
    init (time: DateComponents, days_of_the_week: Array<Bool>, name: String, charity: String, donation: Float) {
        self.time = time
        self.days_of_the_week = days_of_the_week
        self.name = name
        self.charity = charity
        self.donation = donation
    }
}

struct WeekDays: View {
    var days_of_the_week: Array<Bool>
    var days_initials = ["S", "M", "T", "W", "Th", "F", "S"]
    var body: some View {
        HStack{
            ForEach(0 ..< days_initials.count) {
                if self.days_of_the_week[$0] {
                    Text(self.days_initials[$0])
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .background(Color(.blue))
                        .cornerRadius(100)
                    
                }
                else {
                    Text(self.days_initials[$0])
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .background(Color(.gray))
                        .cornerRadius(100)
                }
            }
        }
    }
}

struct AlarmCard: View {
    @State var alarmInfo: AlarmInfo
    @Binding var alarmOn: Bool
    var body: some View {
        
        //        HStack {
        
        VStack(alignment: .leading) {
            Toggle(isOn: $alarmOn) {
                VStack(alignment: .leading, spacing: 5){
                    Text(alarmInfo.name)
                        .font(.title)
                    
    //                Text(alarmInfo.charity)
                    Text("Alarm set for \(alarmInfo.time.hour!):\(alarmInfo.time.minute!)")
                        .font(.body)
                    
                    
                    //            Text("Every \()")
                }
            }
            WeekDays(days_of_the_week: alarmInfo.days_of_the_week)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(25)
        .shadow(color: .gray, radius: 2, x: 0, y: 2)
//            .padding()
        
        //        )
    }
}

struct AlarmCard_Previews: PreviewProvider {
    //    var alarmInfo: AlarmInfo = AlarmInfo(time: DateComponents(hour: 9, minute: 0, second: 0), days_of_the_week: ["Saturday"], charity: "BLM", donation: 1.0)
    static var previews: some View {
        AlarmCard(alarmInfo: AlarmInfo(time: DateComponents(hour: 9, minute: 30, second: 0), days_of_the_week: [true, false, false, false, false, false, true], name: "Saturday Run", charity: "BLM", donation: 1.0), alarmOn: .constant(true))
    }
}
