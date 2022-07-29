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
    var symbol: String?
    var color: Color?
}

func nextElements() -> Elements {
    let colors = [
        Color.red,
        Color.green,
        Color.yellow,
        Color.blue,
        Color.purple,
    ]
    
    let position = Int.random(in: 0..<9)
    let symbol = String(Int.random(in: 0..<10))
    let color = colors[Int.random(in: 0..<colors.count)]
    
    return Elements(position: position, symbol: symbol, color: color)
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
    
    let timer = Timer.publish(every: 0.8, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("\(currentTrial) / \(numberOfTrials)")
                .font(.title2)
            LazyHGrid(rows: Array(repeating: GridItem(.flexible(), spacing: 15), count: 3), spacing: 40) {
                ForEach(0..<9, id:\.self){index in
                    ZStack{
                        if isRunnings {
                            ForEach(selectedModes, id: \.self) {selectedMode in
                                Button("Type X matched") { // TODO: fix
                                    if queue.head  == queue.tail {
                                        backgroundColor = Color.green.opacity(0.5)
                                    } else {
                                        backgroundColor = Color.red.opacity(0.5)
                                    }
                                    
                                }.keyboardShortcut(KeyEquivalent(getKeyByType(selectedMode)), modifiers: [])
                            }
                            
                            
                            if let color = elements.color {
                                if index == elements.position && displayed {
                                    color
                                } else {
                                    Color.white
                                }
                            }
                            
                            if displayed {
                                if let symbol = elements.symbol {
                                    Text(elements.position == index ? symbol : "")
                                        .foregroundColor(symbolColor)
                                        .font(.system(size: 40))
                                }
                            }
                        } else {
                            Color.white
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
                        
                        queue.enqueue(elements.position) // TODO:
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

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main(isRunnings: .constant(true), backgroundColor: .constant(.black), level: 2, trialTime: 1500, numberOfTrials: 25, selectedModes: ["Position", "Audio"])
    }
}
