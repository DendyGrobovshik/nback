//
//  ContentView.swift
//  nback
//
//  Created by Denis Gradoboev on 20.07.2022.
//

import SwiftUI

let DEFAUL_TRIAL_TIME = 2500
let DEFAULT_TRIALS_NUMBER = 25
let DEFAULT_KEYS = ["a", "l", "c", "j", "d"]
let DEFAULT_SELECTED_MODES = ["Position", "Audio"]
let DEFAULT_LEVEL = 2
let AVAILABLE_MODES = ["Position", "Audio", "Color", "Shape", "Digit"]

let TRANSPARENT = Color.black.opacity(0.0)

struct ContentView: View {
    var sessionTime: Int
    
    @State var backgroundColor: Color = TRANSPARENT
    @State var matchesColors: [Dictionary<String, Color>] = [Dictionary()]
    @AppStorage("SELECTED_MODES") var selectedModes: [String] = DEFAULT_SELECTED_MODES
    @AppStorage("LEVEL") var level: Int = DEFAULT_LEVEL
    @AppStorage("TRIAL_TIME") var trialTime: Int = DEFAUL_TRIAL_TIME
    @AppStorage("NUMBER_OF_TRIALS") var numberOfTrials: Int = DEFAULT_TRIALS_NUMBER
    @AppStorage("KEYS") var keys: [String] = DEFAULT_KEYS
    @AppStorage("SCORES") var scores: [Score] = []
    @AppStorage("FIRST_TIME") var firstTime: Bool = true
    
    @State var isRunning: Bool = false
    @State var isShowingHelp: Bool = false
    
    // Animation states
    @State private var isHelpAnimated = false
    @State private var isLogoAnimated = false
    @State private var isStartButtonAnimated = false
    @State private var isSettingHovered = false
    @State private var isHelpHovered = false
    @State private var isHelpPulsing = false
    @State private var isRandomHovered = false
    
    var currentMode: String {
        return getCurrentMode(level, selectedModes)
    }
    
    var body: some View {
        ZStack {
            Button("Start"){
                isRunning.toggle()
                if !isRunning {
                    matchesColors = [Dictionary()]
                }
            }
            .keyboardShortcut(.space, modifiers: [])
            
            Button("Finish"){
                isRunning = false
                matchesColors = [Dictionary()]
            }
            .keyboardShortcut(.escape, modifiers: [])
            
            if isRunning {
                backgroundColor
            } else {
                LinearGradient(colors: [ .red.opacity(0.6), .teal.opacity(0.4), .green.opacity(0.5)], startPoint: .top, endPoint: .bottomTrailing)
            }
            
            Group {
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
                    .offset(x: 605, y: -365)
            }
            
            Text("?")
                .font(.system(size: 30))
                .frame(width: 40, height: 40)
                .background(.gray.opacity(0.4))
                .cornerRadius(30)
                .onTapGesture {
                    self.isShowingHelp = true
                    self.firstTime = false
                }
                .popover(isPresented: $isShowingHelp) {
                    Help(keys: $keys)
                }
                .brightness(isHelpAnimated ? 0.2 : 0)
                .animation(
                    Animation.linear(duration: 2)
                        .repeatForever(autoreverses: true),
                    value: isHelpAnimated
                )
                .onAppear {
                    isHelpAnimated = true
                    isHelpPulsing = true
                }
                .scaleEffect(isHelpHovered ? 1.2 : 1.0)
                .animation(.default, value: isHelpHovered)
                .if(firstTime) {view in
                        view
                        .scaleEffect(isHelpPulsing ? 1.3 : 1)
                        .animation(
                            Animation.linear(duration: 0.2)
                                .delay(0.1)
                                .repeatForever(autoreverses: true),
                            value: isHelpPulsing
                        )
                }
                .onHover { isHovered in
                    self.isHelpHovered = isHovered
                }
                .offset(x: 620, y: -385)
            
            Text("??????")
                .onTapGesture {
                    NSApp.sendAction(
                        Selector(("showPreferencesWindow:")),
                        to: nil,
                        from: nil
                    )
                }
                .font(.system(size: 40))
                .scaleEffect(isSettingHovered ? 1.2 : 1.0)
                .animation(.default, value: isSettingHovered)
                .onHover { isHovered in
                    self.isSettingHovered = isHovered
                }
                .offset(x: 620, y: 385)
            
            Text("????")
                .font(.system(size: 15))
                .cornerRadius(30)
                .onTapGesture {
                    self.level = Int.random(in: 0..<7)
                    self.trialTime = Int(Int.random(in: 1000..<4000) / 100) * 100
                    self.numberOfTrials = Int.random(in: 15..<50) // TODO: Is it necessry?
                    self.selectedModes = Array(AVAILABLE_MODES.choose(Int.random(in: 0..<6)))
                }
                .scaleEffect(isRandomHovered ? 1.2 : 1.0)
                .animation(.default, value: isRandomHovered)
                .onHover { isHovered in
                    self.isRandomHovered = isHovered
                }
                .offset(x: -637, y: 400)
            
            VStack(spacing: 0) {
                HStack {
                    VStack {
                        HStack(spacing: 60) {
                            Logo()
                                .scaleEffect(isLogoAnimated ? 1.1 : 1)
                                .animation(
                                    Animation.linear(duration: 7)
                                        .repeatForever(autoreverses: true),
                                    value: isLogoAnimated
                                )
                                .onAppear {
                                    isLogoAnimated = true
                                }
                            Modes(
                                selectedModes: $selectedModes,
                                keys: keys,
                                matchesColors: matchesColors
                            )
                        }
                        .frame(width: 900, height: 220)
                        HStack {
                            MainSettings(
                                level: $level,
                                trialTime: $trialTime,
                                numberOfTrials: $numberOfTrials
                            )
                            .frame(width: 350, height: 550)
                            Main(
                                isRunnings: $isRunning,
                                matchesColors: $matchesColors,
                                scores: $scores,
                                level: level,
                                trialTime: trialTime,
                                numberOfTrials: numberOfTrials,
                                selectedModes: selectedModes,
                                keys: keys
                            )
                        }
                        .frame(width: 900, height: 550)
                    }
                    .frame(width: 900, height: 800)
                    VStack(spacing: 40) {
                        CurrentMode(currentMode: currentMode)
                        TodayScore(scores: $scores)
                        Image("go")
                            .rotationEffect(Angle(degrees: isStartButtonAnimated ? 5 : 0))
                            .scaleEffect(isStartButtonAnimated ? 1.05 : 1)
                            .animation(
                                Animation.linear(duration: 0.3)
                                    .delay(5)
                                    .repeatForever(autoreverses: false),
                                value: isStartButtonAnimated
                            )
                            .onAppear {
                                isStartButtonAnimated = true
                            }
                            .padding([.bottom], 5)
                            .onTapGesture {
                                isRunning = true
                            }
                    }
                }
                Timeline(sessionTime: sessionTime)
                    .offset(x: 0, y: 14)
            }
            
            if isRunning {
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: 1300, y: 0))
                    path.addLine(to: CGPoint(x: 1300, y: 850))
                    path.addLine(to: CGPoint(x: 900, y: 850))
                    path.addLine(to: CGPoint(x: 900, y: 250))
                    path.addLine(to: CGPoint(x: 380, y: 250))
                    path.addLine(to: CGPoint(x: 380, y: 850))
                    path.addLine(to: CGPoint(x: 0, y: 850))
                }
                .fill(.black.opacity(0.8))
                .blur(radius: 30)
            }
            
            if firstTime {
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: 1210, y: 0))
                    path.addLine(to: CGPoint(x: 1230, y: 70))
                    path.addLine(to: CGPoint(x: 1300, y: 80))
                    path.addLine(to: CGPoint(x: 1300, y: 850))
                    path.addLine(to: CGPoint(x: 0, y: 850))
                }
                .fill(.black.opacity(0.9))
                .blur(radius: 30)
            }
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(sessionTime: 15)
            .frame(width: 1300, height: 800)
    }
}
