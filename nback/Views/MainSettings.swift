//
//  MainSettings.swift
//  nback
//
//  Created by Denis Gradoboev on 26.07.2022.
//

import SwiftUI

// N-back level
// Trial time
// Number of trials
struct MainSettings: View {
    @Binding var level: Int
    @Binding var trialTime: Int
    @Binding var numberOfTrials: Int
    
    var body: some View {
        VStack(spacing: 50) {
            NumberInput(name: "N-back level", value: $level, scale: 2)
                NumberInput(name: "Trial time", value: $trialTime)
                NumberInput(name: "Number of trials", value: $numberOfTrials)
        }
    }
}

struct MainSettings_Previews: PreviewProvider {
    static var previews: some View {
        MainSettings(level: .constant(2), trialTime: .constant(1500), numberOfTrials: .constant(25))
    }
}
