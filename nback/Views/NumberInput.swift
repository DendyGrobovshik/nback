//
//  NumberInput.swift
//  nback
//
//  Created by Denis Gradoboev on 28.07.2022.
//

import SwiftUI

struct NumberInput: View {
    var name: String
    @Binding var value: Int
    @State var scale: Int = 1
    
    private var smallSize: CGFloat {
            return CGFloat(40 * scale)
    }
    
    private var bigSize: Int {
            return 60 * scale
    }
    
    private var length: Int {
        return String(value).count
    }
    
    var body: some View {
        VStack {
            Text(name)
                .font(.largeTitle)
                .gradient(colors: [.cyan, .purple])
            HStack {
                Text("-")
                    .offset(y: -smallSize / 8)
                    .frame(width: smallSize, height: smallSize)
                    .background(.teal.opacity(0.9))
                    .cornerRadius(10)
                    .offset(x: 20)
                    .zIndex(1)
                    .onTapGesture{
                        value -= 1
                    }
                Text(String(value))
                    .frame(width: CGFloat(bigSize * length), height: CGFloat(bigSize))
                    .background(.green.opacity(0.8))
                    .cornerRadius(20)
                
                Text("+")
                    .offset(y: -smallSize / 8)
                    .frame(width: smallSize, height: smallSize)
                    .background(.purple.opacity(0.9))
                    .cornerRadius(10)
                    .offset(x: -20)
                    .onTapGesture{
                        value += 1
                    }
            }
            .font(.system(size: CGFloat(bigSize)))
            .background(.teal.opacity(0.1))
            .cornerRadius(20)
        }            .background(.green.opacity(0.1))
            .cornerRadius(30)
    }
}

struct NumberInput_Previews: PreviewProvider {
    static var previews: some View {
        NumberInput(name: "N-Back level", value: .constant(2))
    }
}
