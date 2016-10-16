//
//  RandomDemoColors.swift
//  Example
//
//  Created by Andre Alves on 10/16/16.
//  Copyright © 2016 Andre Alves. All rights reserved.
//

import Foundation

struct RandomDemoColors {
    private let colors: [DemoColor] = [
        DemoColor(name: "Red", r: 255, g: 0, b: 0),
        DemoColor(name: "Green", r: 0, g: 255, b: 0),
        DemoColor(name: "Blue", r: 0, g: 0, b: 255),
        DemoColor(name: "Yellow", r: 255, g: 255, b: 0),
        DemoColor(name: "Purple", r: 137, g: 104, b: 205),
        DemoColor(name: "Orange", r: 255, g: 165, b: 0),
        DemoColor(name: "Pink", r: 255, g: 52, b: 179),
        DemoColor(name: "Light Gray", r: 211, g: 211, b: 211),
        DemoColor(name: "Gold", r: 255, g: 215, b: 0),
        DemoColor(name: "Firebrick", r: 205, g: 38, b: 38),
        DemoColor(name: "Olive", r: 196, g: 255, b: 62)
    ]

    func randomColors() -> [DemoColor] {
        return Array(colors.shuffle()[0..<randomNumber(colors.count/2..<colors.count)])
    }

    private func randomNumber(_ range: Range<Int>) -> Int {
        let min = range.lowerBound
        let max = range.upperBound
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }
}

extension Array {
    fileprivate func shuffle() -> [Element] {
        var original = self
        var result: [Element] = []
        while original.count > 0 {
            let upperBound = UInt32(original.count - 1)
            let r = Int(arc4random_uniform(upperBound))
            result.append(original.remove(at: r))
        }
        return result
    }
}
