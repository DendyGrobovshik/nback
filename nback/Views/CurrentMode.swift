//
//  CurrentMode.swift
//  nback
//
//  Created by Denis Gradoboev on 28.07.2022.
//

import SwiftUI

struct CurrentMode: View {
    var currentMode: String
    
    private var symbols: [String] {
        return currentMode.map { String($0) }
    }
    
    var body: some View {
        VStack {
            Text("Current mode")
                .font(.largeTitle)
                .gradient(colors: [.green, .red])
            HStack(spacing: 0) {
                ForEach(symbols, id: \.self) {symbol in
                    Image(symbol)
                        .resizable()
                        .frame(width: 60, height: 72)
                        .padding(0)
                }
            }
        }
    }
}

struct CurrentMode_Previews: PreviewProvider {
    static var previews: some View {
        CurrentMode(currentMode: "2PA")
    }
}
