//
//  Mode.swift
//  nback
//
//  Created by Denis Gradoboev on 26.07.2022.
//

import SwiftUI

let SELECTED_COLOR = Color.yellow.opacity(0.8)

struct Mode: View {
    let selected: Bool
    let name: String
    let key: String
    let matchColor: Color
    
    var body: some View {
        ZStack {
            matchColor
                .cornerRadius(10)
                .blur(radius: 10)
            
            VStack{
                ZStack {
                    if selected {
                        SELECTED_COLOR
                    } else {
                        Color.white
                    }
                    
                    Text(key.uppercased())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                .frame(width: 60, height: 70)
                .cornerRadius(10)
                .padding(10)
                
                Text(name)
            }
        }
    }
}

struct Mode_Previews: PreviewProvider {
    static var previews: some View {
        Mode(
            selected: true,
            name: "Audio",
            key: "l",
            matchColor: .green.opacity(1)
        )
        .frame(width: 60, height: 120)
    }
}
