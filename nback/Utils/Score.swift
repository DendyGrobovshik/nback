//
//  Score.swift
//  nback
//
//  Created by Denis Gradoboev on 28.07.2022.
//

import Foundation

struct Score: Identifiable, Codable {
    var id = UUID()
    
    let level: Int
    let selectedModes: [String]
    let percent: Int
    let date: Date
    
    func getScore() -> Int {
        return percent * level * selectedModes.count
    }
    
    func getMode() -> String {
        return getCurrentMode(level, selectedModes)
    }
}
