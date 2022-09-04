//
//  Main.swift
//  nback
//
//  Created by Denis Gradoboev on 22.07.2022.
//

import SwiftUI
import Combine
import Subsonic

func getKeyByType(_ type: String, _ keys: [String]) -> Character {
    var string: String = ""
    
    switch type {
    case "Position":
        string = keys[0]
    case "Audio":
        string = keys[1]
    case "Color":
        string = keys[2]
    case "Shape":
        string = keys[3]
    case "Digit":
        string = keys[4]
    default:
        string = "?"
    }
    
    return Character(string)
}

struct Main: View {
    @Binding var isRunnings: Bool
    @Binding var matchesColors: [Dictionary<String, Color>]
    @Binding var scores: [Score]
    var level: Int
    var trialTime: Int
    var numberOfTrials: Int
    var selectedModes: [String]
    var keys: [String]
    
    @State var currentTrial: Int = 0
    @State private var currentCorrect: Int = 0
    @State private var currentWrong: Int = 0
    @State private var queue: Queue = Queue()
    @State private var displayedStatus: Int = 3
    @State private var elements: Elements = nextElements(nil)
    
    var shape: String {
        if selectedModes.contains("Shape") {
            return elements.shape
        }
        
        return "Rectangle"
    }
    
    var color: Color {
        if selectedModes.contains("Color") {
            return elements.color
        }
        
        return Color.blue
    }
    
    var timer: Publishers.Autoconnect<Timer.TimerPublisher> {
        Timer.publish(every: Double(trialTime) / 3000.0, on: .main, in: .common).autoconnect()
    }
    
    func checkEnd() {
        if currentTrial == numberOfTrials {
            isRunnings = false
            matchesColors = [Dictionary()]
            
            let backsCount = currentCorrect + currentWrong
            let percent = backsCount == 0 ? 100 : Int(currentCorrect  * 100 / backsCount)
            scores.append(Score(level: level, selectedModes: selectedModes, percent: percent, date: Date()))
        }
    }
    
    func addMatch(_ mode: String, _ ok: Bool) {
        if matchesColors[currentTrial][mode] == nil {
            matchesColors[currentTrial][mode] = ok ? .green : .red
            
            let newTimer = Timer(timeInterval: Double(trialTime) / 4000.0, repeats: false) { newTimer in
                matchesColors[currentTrial][mode] = .black.opacity(0)
            }
            RunLoop.current.add(newTimer, forMode: .common)
        }
    }
    
    func checkCorrect(_ selectedMode: String, _ invert: Bool = false) {
        if queue.size < level + 1 {
            return
        }
        // If was already matched(wrong or correct)
        if matchesColors[currentTrial][selectedMode] != nil {
            return
        }
        
        var match = false
        if queue.size > level {
            switch selectedMode {
            case "Position":
                match = queue.head?.position == queue.tail?.position
            case "Audio":
                match = queue.head?.audio == queue.tail?.audio
            case "Color":
                match = queue.head?.color == queue.tail?.color
            case "Shape":
                match = queue.head?.shape == queue.tail?.shape
            case "Digit":
                match = queue.head?.digit == queue.tail?.digit
            default:
                match = false
            }
            
            if invert {
                if match {
                    currentWrong += 1
                    addMatch(selectedMode, false)
                }
            } else {
                if match {
                    currentCorrect += 1
                    addMatch(selectedMode, true)
                } else {
                    currentWrong += 1
                    addMatch(selectedMode, false)
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            // Buttons for cheking matches
            ForEach(selectedModes, id: \.self) {selectedMode in
                Button("") {
                    checkCorrect(selectedMode)
                }.keyboardShortcut(KeyEquivalent(getKeyByType(selectedMode, keys)), modifiers: [])
            }
            
            // Board
            VStack {
                Text("\(currentTrial) / \(numberOfTrials)")
                    .font(.title2)
                LazyHGrid(rows: Array(repeating: GridItem(.flexible(), spacing: 15), count: 3), spacing: 40) {
                    ForEach(0..<9, id:\.self){index in
                        ZStack{
                            Color.white
                            if isRunnings && displayedStatus < 2 {
                                if elements.position == index { // If is selected position
                                    Text("")
                                        .onAppear{
                                            if selectedModes.contains("Audio") {
                                                play(sound: "\(elements.audio).mp3")
                                            }
                                        }
                                    
                                    if selectedModes.contains("Position") { // TODO: default if position isn't selected
                                        switch shape {
                                        case "Rectangle":
                                            Rectangle()
                                                .frame(width: 100, height: 100)
                                                .cornerRadius(5)
                                                .foregroundColor(color)
                                        case "Circle":
                                            Circle()
                                                .frame(width: 100, height: 100)
                                                .foregroundColor(color)
                                        case "Triangle":
                                            Path { path in
                                                path.move(to: CGPoint(x: 60, y: 10))
                                                path.addLine(to: CGPoint(x: 110, y: 100))
                                                path.addLine(to: CGPoint(x: 10, y: 100))
                                            }
                                            .foregroundColor(color)
                                        case "Rhombus":
                                            Path { path in
                                                path.move(to: CGPoint(x: 60, y: 10))
                                                path.addLine(to: CGPoint(x: 110, y: 60))
                                                path.addLine(to: CGPoint(x: 60, y: 110))
                                                path.addLine(to: CGPoint(x: 10, y: 60))
                                            }
                                            .foregroundColor(color)
                                        case "EllipseH":
                                            Ellipse()
                                                .frame(width: 100, height: 50)
                                                .foregroundColor(color)
                                        case "EllipseV":
                                            Ellipse()
                                                .frame(width: 50, height: 100)
                                                .foregroundColor(color)
                                        default:
                                            Text("?")
                                        }
                                    }
                                    
                                    if selectedModes.contains("Digit") {
                                        Text(elements.digit)
                                            .font(.system(size: 40))
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                        .cornerRadius(10)
                        .frame(width: 120, height: 120)
                    }
                }
                .padding(15)
                .frame(width: 500, height: 500)
                .onReceive(timer) { _ in
                    if isRunnings {
                        if displayedStatus == 0 {
                            displayedStatus = 1
                        } else if displayedStatus == 1 {
                            displayedStatus = 2
                        } else if displayedStatus == 2 {
                            displayedStatus = 3
                            selectedModes.forEach {selectedMode in
                                checkCorrect(selectedMode, true)
                            }
                        } else if displayedStatus == 3 {
                            displayedStatus = 0
                            
                            currentTrial += 1
                            matchesColors.append(Dictionary())
                            elements = nextElements(queue)
                            queue.enqueue(elements)
                            if queue.size > level + 1 {
                                queue.drop()
                            }
                            
                            checkEnd()
                        }
                    } else {
                        queue.clear()
                        currentTrial = 0
                        currentCorrect = 0
                        currentWrong = 0
                    }
                }
            }.frame(width: 550, height: 550)
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main(isRunnings: .constant(true), matchesColors: .constant([]), scores: .constant([]), level: 2, trialTime: 1500, numberOfTrials: 25, selectedModes: ["Position", "Digit", "Color", "Shape"], keys: ["a", "l", "f", "j", "d"])
    }
}
