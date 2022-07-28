//
//  Main.swift
//  nback
//
//  Created by Denis Gradoboev on 22.07.2022.
//

import SwiftUI

enum Types: Character {
    case Position = "p"
    case Symbol = "s"
    case Color = "c"
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
    @State private var activeTypes: Array<Types> = [.Position, .Color, .Symbol]
    
    @Binding var backgroundColor: Color
    @Binding var level: Int
    @Binding var trialTime: Int
    @Binding var numberOfTrials: Int

    @State private var queue: Queue = Queue()
    @State private var displayed: Bool = false
    @State private var symbolColor: Color = Color.white
    @State private var elements: Elements = nextElements()
    
    let timer = Timer.publish(every: 0.8, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            LazyHGrid(rows: Array(repeating: GridItem(.flexible(), spacing: 15), count: 3), spacing: 40) {
                ForEach(0..<9, id:\.self){index in
                    ZStack{
                        ForEach(activeTypes, id: \.self) {activeType in
                            Button("Type X matched") { // TODO: fix
                                if queue.head  == queue.tail {
                                    backgroundColor = Color.green.opacity(0.5)
                                } else {
                                    backgroundColor = Color.red.opacity(0.5)
                                }
                                
                            }.keyboardShortcut(KeyEquivalent(activeType.rawValue), modifiers: [])
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
                        
                    }
                    .cornerRadius(10)
                    .frame(width: 120, height: 120)
                }
            }
            .padding(15)
            .frame(width: 500, height: 500)
            .onReceive(timer) { _ in
                if displayed {
                    displayed = false
                    symbolColor = Color.white
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
            }
        }
    }
}

struct Main_Previews: PreviewProvider {
        static var previews: some View {
            Main(backgroundColor: .constant(.black), level: .constant(2), trialTime: .constant(1500), numberOfTrials: .constant(25))
            .frame(width: 500, height: 500)
    }
}
