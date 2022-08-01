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
    
    mutating func clear() {
        elements = []
    }
    
    var head: Elements? {
        return elements.first
    }
    
    var second: Elements? {
        return elements.count > 1 ? elements[1] : nil
    }
    
    var tail: Elements? {
        return elements.last
    }
    
    var size: Int {
        return elements.count
    }
}
