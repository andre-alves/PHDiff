//
//  DiffStep.swift
//  PHDiff
//
//  Created by Andre Alves on 10/13/16.
//  Copyright © 2016 Andre Alves. All rights reserved.
//

import Foundation

public enum DiffStep<T: Diffable> {
    case insert(value: T, index: Int)
    case delete(value: T, index: Int)
    case move(value: T, fromIndex: Int, toIndex: Int)
    case update(value: T, index: Int)

    public var isInsert: Bool {
        switch self {
        case .insert: return true
        default: return false
        }
    }

    public var isDelete: Bool {
        switch self {
        case .delete: return true
        default: return false
        }
    }

    public var isMove: Bool {
        switch self {
        case .move: return true
        default: return false
        }
    }

    public var isUpdate: Bool {
        switch self {
        case .update: return true
        default: return false
        }
    }

    /// The value associated to this step.
    public var value: T {
        switch self {
        case let .insert(value, _): return value
        case let .delete(value, _): return value
        case let .move(value, _, _): return value
        case let .update(value, _): return value
        }
    }

    /// The index associated to this step. In case of Move, it's the toIndex.
    public var index: Int {
        switch self {
        case let .insert(_, index): return index
        case let .delete(_, index): return index
        case let .move(_, _, toIndex): return toIndex
        case let .update(_, index): return index
        }
    }
}

extension DiffStep: Equatable {}

public func ==<T>(lhs: DiffStep<T>, rhs: DiffStep<T>) -> Bool {
    switch (lhs, rhs) {
    case let (.insert(lhsValue, lhsIndex), .insert(rhsValue, rhsIndex)):
        return lhsValue == rhsValue && lhsIndex == rhsIndex
    case let (.delete(lhsValue, lhsIndex), .delete(rhsValue, rhsIndex)):
        return lhsValue == rhsValue && lhsIndex == rhsIndex
    case let (.move(lhsValue, lhsFromIndex, lhsToIndex), .move(rhsValue, rhsFromIndex, rhsToIndex)):
        return lhsValue == rhsValue && lhsFromIndex == rhsFromIndex && lhsToIndex == rhsToIndex
    case let (.update(lhsValue, lhsIndex), .update(rhsValue, rhsIndex)):
        return lhsValue == rhsValue && lhsIndex == rhsIndex
    default:
        return false
    }
}

extension DiffStep: CustomStringConvertible {
    /// Used for debug.
    public var description: String {
        switch self {
        case let .insert(value, index):
            return "Insert \(value) at index: \(index)"
        case let .delete(value, index):
            return "Delete \(value) at index: \(index)"
        case let .move(value, fromIndex, toIndex):
            return "Move \(value) from index: \(fromIndex) to index: \(toIndex)"
        case let .update(value, index):
            return "Update \(value) at index: \(index)"
        }
    }
}
