//
//  alarmSet.swift
//  AlarmTest
//
//  Created by Joshua Segal on 5/30/20.
//  Copyright © 2020 Joshua Segal. All rights reserved.
//

import SwiftUI

struct alarmSet: View {
    @Binding var wakeUp: Date
    @EnvironmentObject var RT: RealTime
    @Binding var alarmIsSet: Bool
    @Binding var pageOpen: Bool
    var body: some View {
        ScrollView{
            VStack(alignment: .center, spacing: 20){
                charitySelection()
                    .padding(.top, 40)
                Text("Set a time")
                    .font(.title)
                DatePicker("", selection: $wakeUp,  displayedComponents: .hourAndMinute).labelsHidden()
                Button(action: setAlarm) {
                    Text("Set Charity Alarm")
                }.buttonStyle(alarmBtnStyle(bgColor: Color(red: 244/255, green: 126/255, blue: 9/255)))
//                NavigationLink(destination: Text("List the charities")) {
                    
//                }
            }
        }
    }
    func setAlarm(){
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: wakeUp)
        self.wakeUp = Calendar.current.date(from: components)!
        
        if wakeUp < RT.date {
            print("wakeUp \(wakeUp) RT \(RT.date)")
            self.wakeUp = wakeUp.addingTimeInterval(86400)
            
        }
        print("wakeUp \(wakeUp) RT \(RT.date)")
        let content = UNMutableNotificationContent()
        content.title = "Quick! Alarm Roulette time!"
        content.subtitle = "Be the first to wake up"
        content.sound = UNNotificationSound.init(named:UNNotificationSoundName(rawValue: "alarm_sound_lady_gaga.mp3"))

        // show this notification five seconds from now
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        for i in 0...2 {
            var dateComponents = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            dateComponents.second = i * 30
//            print(dateComponents)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            // add our notification request
            UNUserNotificationCenter.current().add(request)
        }
        

        self.alarmIsSet = true
        self.pageOpen = false
    }
}

struct alarmSet_Previews: PreviewProvider {
    static var previews: some View {
        alarmSet(wakeUp: .constant(Date()), alarmIsSet: .constant(false), pageOpen: .constant(false) ).environmentObject(RealTime())
    }
}
