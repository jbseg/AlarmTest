//
//  Home.swift
//  AlarmTest
//
//  Created by Joshua Segal on 5/28/20.
//  Copyright © 2020 Joshua Segal. All rights reserved.
//

import SwiftUI


struct Home: View {
    @State var alarmIsSet = false
    @State var showJoin = false
    @State var showResults = false
    @State private var wakeUp = Date()
    @State var showAlarmSheet = false
    @EnvironmentObject var RT: RealTime
    @EnvironmentObject var session: SessionStore
    var body: some View {
        ZStack{
            NavigationView{
                VStack(alignment: .center, spacing: 15){
                    VStack(alignment: .leading){
                        DigitalClock()
                        if alarmIsSet{
                            WakeUpClock(date: wakeUp)
                            if wakeUp <= RT.date && !showResults{
                                Button(action: stopFunc) {
                                    Text("Stop")
                                }.buttonStyle(alarmBtnStyle(bgColor: Color(red: 156/255, green: 157/255, blue: 161/255)))
                            }
                        }
                        if showResults {
                            resultsPreview()
                        }
                    }
                }
                .navigationBarTitle("Alarm Roulette",displayMode: .large)
                .navigationBarItems(
                    trailing:
                    HStack{
                        Button(action: {
                            withAnimation{
                                self.showJoin.toggle()
                            }
                        }, label: {
                            Image(systemName: "person.2").resizable().aspectRatio(contentMode: .fit)
                                .frame(width: 30.0, height: 30.0)
                        })
                        Button(action: {
                            withAnimation{
                                self.showAlarmSheet.toggle()
                            }
                        }, label: {
                            Image(systemName: "plus").resizable()
                                .frame(width: 20.0, height: 20.0)
                        })
                        NavigationLink(destination: UserProfile().environmentObject(session)){
                            Image(systemName: "person.circle").resizable()
                            .frame(width: 25.0, height: 25.0)
                        }
                    }
                )
            }
            if self.showJoin {
                joinMenu(showJoin: self.$showJoin)
            }
        }
//        .onAppear(perform: requestNotificationPermission)
        .sheet(isPresented: $showAlarmSheet) {
            alarmSet(wakeUp: self.$wakeUp, alarmIsSet: self.$alarmIsSet, pageOpen: self.$showAlarmSheet).environmentObject(self.RT)
        }
    }
    
    func stopFunc(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        self.alarmIsSet = false
        self.showResults = true
    }
    
    
//    func requestNotificationPermission(){
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//            if success {
//                print("All set!")
//            } else if let error = error {
//                print(error.localizedDescription)
//            }
//        }
//    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home().environmentObject(RealTime()).environmentObject(SessionStore())
    }
}
