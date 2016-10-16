//
//  Array+ApplyDiff.swift
//  PHDiff
//
//  Created by Andre Alves on 10/13/16.
//  Copyright © 2016 Andre Alves. All rights reserved.
//

import Foundation

extension Array where Element: Diffable {
    public func apply(steps: [DiffStep<Element>]) -> [Element] {
        var copy = self

        for step in steps {
            switch step {
            case let .Insert(value, index):
                copy.insert(value, at: index)

            case let .Delete(_, index):
                copy.remove(at: index)

            case let .Move(value, fromIndex, toIndex):
                copy.remove(at: fromIndex)
                copy.insert(value, at: toIndex)

            case let .Update(value, index):
                copy[index] = value
            }
        }

        return copy
    }
}
