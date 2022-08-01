//
//  Utils.swift
//  nback
//
//  Created by Denis Gradoboev on 31.07.2022.
//

import Foundation

func getCurrentMode(_ level: Int, _ selectedModes: [String]) -> String {
    return String(level) + selectedModes.map { $0.prefix(1) }.joined(separator: "")
}