//
//  Random.swift
//  PHDiff
//
//  Created by Andre Alves on 10/16/16.
//  Copyright © 2016 Andre Alves. All rights reserved.
//

import Foundation

func randomArray(length: Int) -> [String] {
    let charactersString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let charactersArray: [Character] = Array(charactersString)

    var array: [String] = []
    for _ in 0..<length {
        array.append(String(charactersArray[Int(arc4random()) % charactersArray.count]))
    }

    return array
}

func randomNumber(_ range: Range<Int>) -> Int {
    let min = range.lowerBound
    let max = range.upperBound
    return Int(arc4random_uniform(UInt32(max - min))) + min
}
