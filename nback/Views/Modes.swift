//
//  Modes.swift
//  nback
//
//  Created by Denis Gradoboev on 26.07.2022.
//

import SwiftUI

struct Modes: View {
    @Binding var selectedModes: [String]
    let modes = ["Position", "Audio", "Color", "Shape", "Digit"]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Modes >")
                .font(.largeTitle)
                .gradient()
                .padding(5)
            
            HStack {
                ForEach(modes, id: \.self) {mode in
                    Mode(selected: selectedModes.contains(mode), name: mode)
                        .onTapGesture{
                            if selectedModes.contains(mode) {
                                selectedModes = selectedModes.filter { $0 != mode }
                            } else {
                                selectedModes.append(mode)
                            }
                        }
                }
            }
        }
    }
}

struct Modes_Previews: PreviewProvider {
    static var previews: some View {
        Modes(selectedModes: .constant(["Position"]))
    }
}
