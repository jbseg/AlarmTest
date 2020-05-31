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
    @State var showingDetail = false
    
    var body: some View {
        ZStack{
            NavigationView{
                VStack(alignment: .center, spacing: 15){
                    VStack(alignment: .leading){
                        DigitalClock()
                        if alarmIsSet{
                            HStack{
                                WakeUpClock(date: wakeUp)
                                RingingAnim(wakeUp: wakeUp)
                            }
                            if wakeUp <= RT.date  {
                                Button(action: stopFunc) {
                                    Text("Stop")
                                }.buttonStyle(alarmBtnStyle(bgColor: Color(red: 156/255, green: 157/255, blue: 161/255)))
                            }
                        }
                    }
                }
                .navigationBarTitle("Alarm Roulette",displayMode: .large)
                .navigationBarItems(
                    trailing:
                        Button(action: {
                            withAnimation{
                                self.showingDetail.toggle()
                            }
                        }, label: {
                            Image(systemName: "plus").resizable()
                                .frame(width: 20.0, height: 20.0)
                        })
                )
            }
        }.onAppear(perform: requestNotificationPermission)
        .sheet(isPresented: $showingDetail) {
            alarmSet(wakeUp: self.$wakeUp, alarmIsSet: self.$alarmIsSet, pageOpen: self.$showingDetail).environmentObject(self.RT)
        }
    }
    
    func stopFunc(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        self.alarmIsSet = false
    }
    
    
    func requestNotificationPermission(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
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
