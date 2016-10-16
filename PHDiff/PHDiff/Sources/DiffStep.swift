//
//  DiffStep.swift
//  PHDiff
//
//  Created by Andre Alves on 10/13/16.
//  Copyright © 2016 Andre Alves. All rights reserved.
//

import Foundation

public enum DiffStep<T> {
    case Insert(value: T, index: Int)
    case Delete(value: T, index: Int)
    case Move(value: T, fromIndex: Int, toIndex: Int)
    case Update(value: T, index: Int)

    public var isInsert: Bool {
        switch self {
        case .Insert: return true
        default: return false
        }
    }

    public var isDelete: Bool {
        switch self {
        case .Delete: return true
        default: return false
        }
    }

    public var isMove: Bool {
        switch self {
        case .Move: return true
        default: return false
        }
    }

    public var isUpdate: Bool {
        switch self {
        case .Update: return true
        default: return false
        }
    }

    /// The value associated to this step.
    public var value: T {
        switch self {
        case let .Insert(value, _): return value
        case let .Delete(value, _): return value
        case let .Move(value, _, _): return value
        case let .Update(value, _): return value
        }
    }

    /// The index associated to this step. In case of Move, it's the toIndex.
    public var index: Int {
        switch self {
        case let .Insert(_, index): return index
        case let .Delete(_, index): return index
        case let .Move(_, _, toIndex): return toIndex
        case let .Update(_, index): return index
        }
    }
}

extension DiffStep: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .Insert(value, index):
            return "Insert \(value) at index: \(index)"
        case let .Delete(value, index):
            return "Delete \(value) at index: \(index)"
        case let .Move(value, fromIndex, toIndex):
            return "Move \(value) from index: \(fromIndex) to index: \(toIndex)"
        case let .Update(value, index):
            return "Update \(value) at index: \(index)"
        }
    }
}
