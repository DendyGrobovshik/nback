//
//  Modes.swift
//  nback
//
//  Created by Denis Gradoboev on 26.07.2022.
//

import SwiftUI

struct Modes: View {
    @Binding var selectedModes: [String]
    let keys: [String]
    let matchesColors: [Dictionary<String, Color>]
    let modes = AVAILABLE_MODES
    
    func getMatchColor(_ mode: String) -> Color {
        if matchesColors.count > 0 {
            if let color = matchesColors.last![mode] {
                return color
            }
        }
        
        return TRANSPARENT
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Modes >")
                .font(.largeTitle)
                .gradient()
                .padding(5)
            
            HStack {
                ForEach(Array(modes.enumerated()), id: \.offset) {index, mode in
                    Mode(
                        selected: selectedModes.contains(mode),
                        name: mode, key: keys[index],
                        matchColor: getMatchColor(mode)
                    )
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
        Modes(
            selectedModes: .constant(["Position"]),
            keys: DEFAULT_KEYS,
            matchesColors: []
        )
    }
}
