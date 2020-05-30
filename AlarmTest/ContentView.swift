//
//  ContentView.swift
//  AlarmTest
//
//  Created by Joshua Segal on 5/28/20.
//  Copyright © 2020 Joshua Segal. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @State var alarmIsSet = false
    @State private var wakeUp = Date()
    @EnvironmentObject var RT: RealTime
    let center = UNUserNotificationCenter.current()
    
    var body: some View {
        ZStack{
            Color.black
            .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 15){
                VStack(alignment: .leading){
                    DigitalClock()
                    if alarmIsSet{
                        HStack{
                            WakeUpClock(date: wakeUp)
                            RingingAnim(wakeUp: wakeUp)
                        }
                    }
                }
                VStack(spacing: 10){
                    if !alarmIsSet {
                        DatePicker("", selection: $wakeUp,  displayedComponents: .hourAndMinute).labelsHidden()
                        .colorMultiply(Color.white)
                        .colorInvert()
                        Button(action: setAlarm) {
                            Text("Set Alarm")
                        }.buttonStyle(alarmBtnStyle(bgColor: Color(red: 244/255, green: 126/255, blue: 9/255)))
                        
                    }
                    else if wakeUp <= RT.date  {
                        Button(action: stopFunc) {
                            Text("Stop")
                        }.buttonStyle(alarmBtnStyle(bgColor: Color(red: 156/255, green: 157/255, blue: 161/255)))
                        
                    }
                }
            }
        }.onAppear(perform: requestNotificationPermission)
    }

    
    func stopFunc(){
        center.getPendingNotificationRequests { (notificationRequests) in
             for notificationRequest:UNNotificationRequest in notificationRequests {
                print(notificationRequest.identifier)
            }
        }
        center.removeAllPendingNotificationRequests()
        self.alarmIsSet = false
    }
    
    func setAlarm(){
//        self.wakeUp = Calendar.current.date(bySetting: .second, value: 0, of: wakeUp)!
        if wakeUp < RT.date {
            print("wakeUp \(wakeUp) RT \(RT.date)")
            self.wakeUp = wakeUp.addingTimeInterval(86400)
            print("wakeUp \(wakeUp) RT \(RT.date)")
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Quick! Alarm Roulette time!"
        content.subtitle = "Be the first to wake up"
        content.sound = UNNotificationSound.init(named:UNNotificationSoundName(rawValue: "alarm_sound_lady_gaga.mp3"))

        // show this notification five seconds from now
        for i in 0...2 {
            var dateComponents = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            dateComponents.second = i * 30
//            print(dateComponents)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            // add our notification request
            center.add(request)
        }
        

        self.alarmIsSet = true
    }
    
    func requestNotificationPermission(){
        center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(RealTime())
    }
}
