//
//  RealTime.swift
//  AlarmTest
//
//  Created by Joshua Segal on 5/29/20.
//  Copyright © 2020 Joshua Segal. All rights reserved.
//

import SwiftUI

class RealTime: ObservableObject {
    @Published var date = Date()

    init() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in
          self.date = Date()
        })
    }
}
