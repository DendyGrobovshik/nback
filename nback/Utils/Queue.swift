//
//  Queue.swift
//  nback
//
//  Created by Denis Gradoboev on 24.07.2022.
//

import Foundation

struct Queue {
    private var elements: [Int] = []
    
    mutating func enqueue(_ value: Int) {
        elements.append(value)
    }
    
    mutating func dequeue() -> Int? {
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
    
    func toString() -> String {
        return elements.map(String.init).joined(separator: "->")
    }
    
    var head: Int? {
        return elements.first
    }
    
    var tail: Int? {
        return elements.last
    }
    
    var size: Int {
        return elements.count
    }
}
