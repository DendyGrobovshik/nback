//
//  ContentView.swift
//  nback
//
//  Created by Denis Gradoboev on 20.07.2022.
//

import SwiftUI

struct ContentView: View {
    @State var backgroundColor: Color = .black.opacity(0.0)
    @State var selectedModes: [String] = ["Position", "Audio"]
    @State var level: Int = 2
    @State var trialTime: Int = 1500
    @State var numberOfTrials: Int = 25
    
    var currentMode: String {
        return String(level) + selectedModes.map { $0.prefix(1) }.joined(separator: "")
    }
    
    var body: some View {

        ZStack {
            LinearGradient(colors: [ .red.opacity(0.6), .teal.opacity(0.4), .green.opacity(0.5)], startPoint: .top, endPoint: .bottomTrailing)
            
            backgroundColor
            
            Circle()
                .frame(width: 400)
                .foregroundColor(.blue.opacity(0.6))
                .blur(radius: 50)
                .offset(x: 440, y: -300)
            
            Circle()
                .frame(width: 300)
                .foregroundColor(.white.opacity(0.5))
                .blur(radius: 70)
                .offset(x: -440, y: -300)
            
            Ellipse()
                .frame(width: 300)
                .foregroundColor(.yellow.opacity(0.6))
                .blur(radius: 80)
                .offset(x: 100, y: 600)
                .rotationEffect(.degrees(-45))
            
            Rectangle()
                .frame(width: 300)
                .foregroundColor(.indigo.opacity(0.7))
                .blur(radius: 100)
                .offset(x: -300)
                .rotationEffect(.degrees(-45))
            
            HStack {
                VStack{
                    HStack(spacing: 60) {
                        Logo()
                        Modes(selectedModes: $selectedModes)
                    }
                    .frame(width: 900, height: 250)
                    HStack {
                        MainSettings(level: $level, trialTime: $trialTime, numberOfTrials: $numberOfTrials)
                            .frame(width: 350, height: 550)
                        VStack {
                            Main(backgroundColor: $backgroundColor, level: $level, trialTime: $trialTime, numberOfTrials: $numberOfTrials)
                        }
                        .frame(width: 550, height: 550)
                    }
                    .frame(width: 900, height: 550)
                }
                .frame(width: 900, height: 800)
                VStack(spacing: 60) {
                    CurrentMode(currentMode: currentMode)
                    TodayScore()
                }
                .frame(width: 380, height: 800)
            }
            .frame(width: 1280, height: 800)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
