//
//  Engine.swift
//  nback
//
//  Created by Denis Gradoboev on 30.08.2022.
//

import Foundation
import SwiftUI

struct Elements {
    var position: Int
    var audio: Int
    var color: Color
    var shape: String
    var digit: String
}

func nextElements(_ queue: Queue?) -> Elements {
    let repeatRate = 25
    let fakeRepeat = 10
    
    func needRepeat() -> Bool {
        return repeatRate > Int.random(in: 0..<100)
    }
    
    func needFakeRepeat() -> Bool {
        return fakeRepeat > Int.random(in: 0..<100)
    }
    
    let colors = [
        Color.red,
        Color.green,
        Color.yellow,
        Color.blue,
        Color.purple,
        Color.black,
        Color.gray,
    ]
    
    let shapes = [
        "Rectangle",
        "Circle",
        "Triangle",
        "Rhombus",
        "EllipseH",
        "EllipseV",
    ]
    
    var position = Int.random(in: 0..<9)
    var digit = String(Int.random(in: 0..<10))
    var color = colors[Int.random(in: 0..<colors.count)]
    var shape = shapes[Int.random(in: 0..<shapes.count)]
    var audio = Int.random(in: 1..<9)
    
    if let second = queue?.second {
        if queue != nil && needFakeRepeat() {
            position = second.position
        }
        if queue != nil && needFakeRepeat() {
            digit = second.digit
        }
        if queue != nil && needFakeRepeat() {
            color = second.color
        }
        if queue != nil && needFakeRepeat() {
            shape = second.shape
        }
        if queue != nil && needFakeRepeat() {
            audio = second.audio
        }
    }
    
    if let head = queue?.head {
        if queue != nil && needRepeat() {
            position = head.position
        }
        if queue != nil && needRepeat() {
            digit = head.digit
        }
        if queue != nil && needRepeat() {
            color = head.color
        }
        if queue != nil && needRepeat() {
            shape = head.shape
        }
        if queue != nil && needRepeat() {
            audio = head.audio
        }
    }
    
    return Elements(position: position, audio: audio, color: color, shape: shape, digit: digit)
}
