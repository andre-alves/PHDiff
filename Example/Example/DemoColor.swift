//
//  DemoColor.swift
//  Example
//
//  Created by Andre Alves on 10/13/16.
//  Copyright © 2016 Andre Alves. All rights reserved.
//

import UIKit
import PHDiff

struct DemoColor {
    let name: String
    let r: Float
    let g: Float
    let b: Float

    func toUIColor() -> UIColor {
        return UIColor(red: CGFloat(r)/255,
                       green: CGFloat(g)/255,
                       blue: CGFloat(b)/255,
                       alpha: 1.0)
    }
}

extension DemoColor: Diffable {
    var diffIdentifier: String {
        return name
    }
}

func ==(lhs: DemoColor, rhs: DemoColor) -> Bool {
    return lhs.name == rhs.name && lhs.r == rhs.r && lhs.b == rhs.b && lhs.g == rhs.g
}
