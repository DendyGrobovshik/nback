//
//  Level.swift
//  nback
//
//  Created by Denis Gradoboev on 26.07.2022.
//

import SwiftUI

struct Level: View {
    @State private var value: Int = 2
    
    var body: some View {
        VStack {
            Text("N back level")
                .font(.largeTitle)
            HStack {
                Text("-")
                    .frame(width: 80, height: 80)
                    .background(.brown)
                    .cornerRadius(20)
                    .offset(x: 20)
                    .zIndex(1)
                    .onTapGesture{
                        value -= 1
                    }
                Text(String(value))
                    .frame(width: 100)
                    .background(.gray)
                    .cornerRadius(20)
                
                Text("+")
                    .frame(width: 80, height: 80)
                    .background(.brown)
                    .cornerRadius(20)
                    .offset(x: -20)
                    .onTapGesture{
                        value += 1
                    }
            }
            .font(.system(size: 100))
//            .frame(width: 150)
        }
    }
}

struct Level_Previews: PreviewProvider {
    static var previews: some View {
        Level()
    }
}
