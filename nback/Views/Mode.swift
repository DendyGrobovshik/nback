//
//  Mode.swift
//  nback
//
//  Created by Denis Gradoboev on 26.07.2022.
//

import SwiftUI

struct Mode: View {
    let selected: Bool
    let name: String
    let key: String
    
    var body: some View {
        VStack{
        ZStack {
            if selected {
                Color.yellow.opacity(0.8)
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

struct Mode_Previews: PreviewProvider {
    static var previews: some View {
        Mode(selected: true, name: "Audio", key: "l")
    }
}
