//
//  ContentView.swift
//  nback
//
//  Created by Denis Gradoboev on 20.07.2022.
//

import SwiftUI

struct ContentView: View {
    @State var backgroundColor: Color = .black.opacity(0.0)
    @State var matches: [Dictionary<String, Bool>] = []
    @AppStorage("SELECTED_MODES") var selectedModes: [String] = ["Position", "Audio"]
    @AppStorage("LEVEL") var level: Int = 2
    @AppStorage("TRIAL_TIME") var trialTime: Int = 1500
    @AppStorage("NUMBER_OF_TRIALS") var numberOfTrials: Int = 25
    @AppStorage("KEYS") var keys: [String] = ["a", "l", "c", "j", "d"]
    @AppStorage("SCORES") var scores: [Score] = []
    
    @State var isRunning: Bool = false
    @State var isShowingHelp: Bool = false
    
    // Animation states
    @State private var isHelpAnimated = false
    @State private var isLogoAnimated = false
    @State private var isStartButtonAnimated = false
    
    var currentMode: String {
        return getCurrentMode(level, selectedModes)
    }
    
    var body: some View {
        ZStack {
            Button("Start"){
                isRunning = true
            }
            .keyboardShortcut(.space, modifiers: [])
            
            Button("Finish"){
                isRunning = false
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
                .font(.system(size: 40))
                .frame(width: 50, height: 50)
                .background(.gray.opacity(0.4))
                .cornerRadius(30)
                .onTapGesture {
                    self.isShowingHelp = true
                }
                .popover(isPresented: $isShowingHelp) {
                    Help(keys: $keys)
                }
                .brightness(isHelpAnimated ? 0.2 : 0)
                .animation(Animation.linear(duration: 2).repeatForever(autoreverses: true), value: isHelpAnimated)
                .onAppear {
                    isHelpAnimated = true
                }
                .offset(x: 620, y: -385)
            
            Text("🎲")
                .font(.system(size: 15))
                .cornerRadius(30)
                .onTapGesture {
                    self.level = Int.random(in: 0..<7)
                    self.trialTime = Int(Int.random(in: 1000..<4000) / 100) * 100
                    self.numberOfTrials = Int.random(in: 15..<50) // TODO: Is it necessry?
                    self.selectedModes = Array(["Position", "Audio", "Color", "Shape", "Digit"].choose(Int.random(in: 0..<6)))
                }
                .offset(x: -637, y: 400)
            
            HStack {
                VStack{
                    HStack(spacing: 60) {
                        Logo()
                            .scaleEffect(isLogoAnimated ? 1.1 : 1)
                            .animation(Animation.linear(duration: 7).repeatForever(autoreverses: true), value: isLogoAnimated)
                            .onAppear {
                                isLogoAnimated = true
                            }
                        Modes(selectedModes: $selectedModes, keys: keys, matches: matches)
                    }
                    .frame(width: 900, height: 250)
                    HStack {
                        MainSettings(level: $level, trialTime: $trialTime, numberOfTrials: $numberOfTrials)
                            .frame(width: 350, height: 550)
                        Main(isRunnings: $isRunning, matches: $matches, scores: $scores, level: level, trialTime: trialTime, numberOfTrials: numberOfTrials, selectedModes: selectedModes, keys: keys)
                    }
                    .frame(width: 900, height: 550)
                }
                .frame(width: 900, height: 800)
                VStack(spacing: 40) {
                    CurrentMode(currentMode: currentMode)
                    TodayScore(scores: $scores)
                    Image("go")
                        .rotationEffect(Angle(degrees: isStartButtonAnimated ? 7 : 0))
                        .scaleEffect(isLogoAnimated ? 1.05 : 1)
                        .animation(Animation.linear(duration: 0.3).delay(5).repeatForever(autoreverses: false), value: isStartButtonAnimated)
                        .onAppear {
                            isStartButtonAnimated = true
                        }
                        .padding([.bottom], 5)
                        .onTapGesture {
                            isRunning = true
                        }
                }
            }
            .frame(width: 380, height: 800)
            
            if isRunning {
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: 1280, y: 0))
                    path.addLine(to: CGPoint(x: 1280, y: 800))
                    path.addLine(to: CGPoint(x: 900, y: 800))
                    path.addLine(to: CGPoint(x: 900, y: 250))
                    path.addLine(to: CGPoint(x: 380, y: 250))
                    path.addLine(to: CGPoint(x: 380, y: 800))
                    path.addLine(to: CGPoint(x: 0, y: 800))
                }
                .fill(.black.opacity(0.8))
                .blur(radius: 30)
            }
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 1300, height: 800)
    }
}
