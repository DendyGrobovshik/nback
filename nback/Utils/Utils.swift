//
//  Utils.swift
//  nback
//
//  Created by Denis Gradoboev on 31.07.2022.
//

import Foundation
import SwiftUI

func getCurrentMode(_ level: Int, _ selectedModes: [String]) -> String {
    return String(level) + selectedModes.map { $0.prefix(1) }.joined(separator: "")
}

// Getting subarray of size n
extension Collection {
    func choose(_ n: Int) -> ArraySlice<Element> { shuffled().prefix(n) }
}

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
