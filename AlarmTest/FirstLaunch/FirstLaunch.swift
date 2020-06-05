//
//  FirstLaunch.swift
//  AlarmTest
//
//  Created by Joshua Segal on 6/3/20.
//  Copyright © 2020 Joshua Segal. All rights reserved.
//

import Foundation
import SwiftUI

class FirstLaunch: ObservableObject {
//    @Published var date = Date()
    
//    let userDefaults: UserDefaults = .standard
    @Published var wasLaunchedBefore: Bool
    var isFirstLaunch: Bool {
        return !wasLaunchedBefore
    }
    
    init() {
        let wasLaunchedBefore = UserDefaults.standard.bool(forKey: "launched")
        self.wasLaunchedBefore = wasLaunchedBefore
//        if !wasLaunchedBefore {
//            userDefaults.set(true, forKey: key)
//        }
    }
    
    func firstLaunchComplete(){
        UserDefaults.standard.set(true, forKey: "launched")
        withAnimation(.easeInOut(duration: 0.5)) {
            self.wasLaunchedBefore = true
        }
    }
    
}
