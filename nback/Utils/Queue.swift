//
//  Queue.swift
//  nback
//
//  Created by Denis Gradoboev on 24.07.2022.
//

import Foundation

struct Queue {
    private var elements: [Elements] = []
    
    mutating func enqueue(_ value: Elements) {
        elements.append(value)
    }
    
    mutating func dequeue() -> Elements? {
        guard !elements.isEmpty else {
            return nil
        }
        return elements.removeFirst()
    }
    
    mutating func drop() {
        guard !elements.isEmpty else {
            return
        }
        elements.removeFirst()
    }
    
    var head: Elements? {
        return elements.first
    }
    
    var tail: Elements? {
        return elements.last
    }
    
    var size: Int {
        return elements.count
    }
}
