//
//  Help.swift
//  nback
//
//  Created by Denis Gradoboev on 29.08.2022.
//

import SwiftUI

func getTypeById(_ id: Int) -> String {
    switch id {
    case 0:
        return "Position"
    case 1:
        return "Audio"
    case 2:
        return "Color"
    case 3:
        return "Shape"
    case 4:
        return "Digit"
    default:
        return "?"
    }
}

let defaultKeys = ["a", "l", "c", "j", "d"]

struct Help: View {
    let urlWiki = URL(string: "https://en.wikipedia.org/wiki/N-back")
    let urlGwern = URL(string: "https://www.gwern.net/DNB-FAQ")
    
    @Binding var keys: [String]
    
    var body: some View {
        let validatingKeys = Binding<[String]>(get: {
            self.keys
        }, set: {
            self.keys = $0
            for i in 0..<self.keys.count {
                if self.keys[i].count == 0 {
                    self.keys[i] = defaultKeys[i]
                }
                if self.keys[i].count > 1 {
                    let last = (self.keys[i].last?.lowercased())!
                    
                    self.keys[i] = last
                }
            }
        })
        
        VStack {
            Text("Space").foregroundColor(.green) + Text(" to start")
            Text("ESC").foregroundColor(.green) + Text(" to stop")
            ForEach(0..<5, id:\.self){index in
                HStack {
                    Text("Key for ")
                    + Text (getTypeById(index)).foregroundColor(.green)
                    + Text(" match")
                    Spacer()
                    TextField(
                        "",
                        text: validatingKeys[index]
                    )
                    .frame(width: 40, height: 40)
                    .multilineTextAlignment(.center)
                }
                .padding(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.gray, lineWidth: 1)
                )
                .frame(width: 320)
            }

            
            Link("Wiki about n-back", destination: urlWiki!)
            Link("Comprehensive article", destination: urlGwern!)
        }
        .font(.largeTitle)
        .padding()
    }
}

struct Help_Previews: PreviewProvider {
    static var previews: some View {
        Help(keys: .constant(["a", "l", "f", "j", "d"]))
    }
}
