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
            case let .insert(value, index):
                copy.insert(value, at: index)

            case let .delete(_, index):
                copy.remove(at: index)

            case let .move(value, fromIndex, toIndex):
                copy.remove(at: fromIndex)
                copy.insert(value, at: toIndex)

            case let .update(value, index):
                copy[index] = value
            }
        }

        return copy
    }
}
