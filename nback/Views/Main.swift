//
//  Main.swift
//  nback
//
//  Created by Denis Gradoboev on 22.07.2022.
//

import SwiftUI

func getKeyByType(_ type: String) -> Character {
    switch type {
    case "Position":
        return "p"
    case "Audio":
        return "a"
    case "Color":
        return "a"
    case "Shape":
        return "a"
    case "Math":
        return "a"
    default:
        return "?"
    }
}

struct Elements {
    var position: Int
    var audio: Int
    var color: Color
    var shape: String
    var digit: String
}

func nextElements() -> Elements {
    let colors = [
        Color.red,
        Color.green,
        Color.yellow,
        Color.blue,
        Color.purple,
        Color.black,
        Color.gray,
    ]
    
    let shapes = [
        "Rectangle",
        "Circle",
        "Triangle",
        "Rhombus",
        "EllipseH",
        "EllipseV",
    ]
    
    let position = Int.random(in: 0..<9)
    let digit = String(Int.random(in: 0..<10))
    let color = colors[Int.random(in: 0..<colors.count)]
    let shape = shapes[Int.random(in: 0..<shapes.count)]
    let audio = (Int.random(in: 0..<9))
    
    return Elements(position: position, audio: audio, color: color, shape: shape, digit: digit)
}


struct Main: View {
    @Binding var isRunnings: Bool
    @Binding var backgroundColor: Color
    var level: Int
    var trialTime: Int
    var numberOfTrials: Int
    var selectedModes: [String]
    
    @State var currentTrial: Int = 0
    @State private var queue: Queue = Queue()
    @State private var displayed: Bool = false
    @State private var symbolColor: Color = Color.white
    @State private var elements: Elements = nextElements()
    
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
    
    let timer = Timer.publish(every: 0.8, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            // Buttons for cheking matches
            ForEach(selectedModes, id: \.self) {selectedMode in
                Button("") {
                    var match = false
                    if queue.size >= level {
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
                        
                        if match {
                            backgroundColor = Color.green.opacity(0.5)
                        } else {
                            backgroundColor = Color.red.opacity(0.5)
                        }
                    }
                    
                }.keyboardShortcut(KeyEquivalent(getKeyByType(selectedMode)), modifiers: [])
            }
            
            // Board
            VStack {
                Text("\(currentTrial) / \(numberOfTrials)")
                    .font(.title2)
                LazyHGrid(rows: Array(repeating: GridItem(.flexible(), spacing: 15), count: 3), spacing: 40) {
                    ForEach(0..<9, id:\.self){index in
                        ZStack{
                            Color.white
                            if isRunnings {
                                if elements.position == index { // If is selected position
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
                                            .foregroundColor(.black)
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
                        if displayed {
                            displayed = false
                            symbolColor = Color.white
                            
                            currentTrial += 1
                            if currentTrial == numberOfTrials {
                                isRunnings = false
                                currentTrial = 0
                            }
                        } else {
                            displayed = true
                            symbolColor = Color.black
                            
                            elements = nextElements()
                            
                            queue.enqueue(elements)
                            if queue.size > level + 1 {
                                queue.drop()
                            }
                        }
                        
                        backgroundColor = .black.opacity(0.0)
                    } else {
                        currentTrial = 0
                    }
                }
            }.frame(width: 550, height: 550)
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main(isRunnings: .constant(true), backgroundColor: .constant(.black), level: 2, trialTime: 1500, numberOfTrials: 25, selectedModes: ["Position", "Digit", "Color", "Shape"])
    }
}
