//
//  Timeline.swift
//  nback
//
//  Created by Denis Gradoboev on 30.08.2022.
//

import SwiftUI
import Combine

let WIDTH_COEF = 1300

struct Timeline: View {
    @State var currentTime: Int = 0
    var sessionTime: Int
    
    // Update every second
    var timer: Publishers.Autoconnect<Timer.TimerPublisher> {
        Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    }
    
    var traversed: CGFloat {
        CGFloat((WIDTH_COEF * currentTime) / (60 * sessionTime))
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.green)
                .frame(
                    minWidth: CGFloat(WIDTH_COEF),
                    idealWidth: CGFloat(WIDTH_COEF),
                    maxWidth: CGFloat(WIDTH_COEF),
                    minHeight: 6,
                    idealHeight: 6,
                    maxHeight: 6
                )
                .onReceive(timer) { _ in
                    currentTime += 1
                    
                    // Session end
                    if currentTime >= 150 {
                        currentTime = 0
                    }
                }
            
            Rectangle()
                .foregroundColor(.red)
                .frame(
                    minWidth: traversed,
                    idealWidth: traversed,
                    maxWidth: traversed,
                    minHeight: 6,
                    idealHeight: 6,
                    maxHeight: 6
                )
        }
    }
}

struct Timeline_Previews: PreviewProvider {
    static var previews: some View {
        Timeline(sessionTime: 15)
    }
}
