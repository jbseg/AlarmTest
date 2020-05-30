//
//  BtnStyles.swift
//  AlarmTest
//
//  Created by Joshua Segal on 5/29/20.
//  Copyright © 2020 Joshua Segal. All rights reserved.
//

import SwiftUI

struct alarmBtnStyle: ButtonStyle {
    var bgColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 200, height: 20, alignment: .center)
            .foregroundColor(Color.white)
            .padding()
            .background(bgColor)
            .cornerRadius(40)
    }
}
