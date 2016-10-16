//
//  DiffContext.swift
//  PHDiff
//
//  Created by Andre Alves on 10/13/16.
//  Copyright © 2016 Andre Alves. All rights reserved.
//

// DiffContext is the initial setup of the OA and NA arrays. It is than processed to create the diff steps.
// By the end of `setupContext`, the context is the state showed at the figure 1 of the Paul Heckel's paper.

import Foundation

public final class DiffContext<T: Diffable> {
    public private(set) var fromArray: [T] // O
    public private(set) var toArray: [T] // N
    public private(set) var OA: [Reference] = []
    public private(set) var NA: [Reference] = []
    public private(set) var table: [T.HashType: Reference.Symbol] = [:]

    /// Creates and setups the context.
    /// Complexity: O(n+m) where n is fromArray.count and m is toArray.count.
    public init(fromArray: [T], toArray: [T]) {
        self.fromArray = fromArray
        self.toArray = toArray
        self.setupContext()
    }

    private func setupContext() {
        // The context setup is made in 5 passes.

        // First pass
        for obj in toArray {
            let symbol = table[obj.diffIdentifier] ?? Reference.Symbol()
            symbol.newCounter += 1
            table[obj.diffIdentifier] = symbol
            NA.append(.Pointer(symbol))
        }

        // Second pass
        for (index, obj) in fromArray.enumerated() {
            let symbol = table[obj.diffIdentifier] ?? Reference.Symbol()
            symbol.oldCounter += 1
            symbol.oldIndex = index
            table[obj.diffIdentifier] = symbol
            OA.append(.Pointer(symbol))
        }

        // Third pass
        for (index, ref) in NA.enumerated() {
            if let symbol = ref.symbol, symbol.newCounter == symbol.oldCounter && symbol.newCounter == 1 {
                NA[index] = .Index(symbol.oldIndex)
                OA[symbol.oldIndex] = .Index(index)
            }
        }

        // Forth pass
        var i = 1
        while(i < NA.count-1) {
            if let j = NA[i].index, j+1 < OA.count {
                if NA[i+1].symbol != nil && NA[i+1].symbol === OA[j+1].symbol {
                    NA[i+1] = .Index(j+1)
                    OA[j+1] = .Index(i+1)
                }
            }
            i += 1
        }

        // Fifth pass
        i = NA.count-1
        while(i > 0) {
            if let j = NA[i].index, j-1 >= 0 {
                if NA[i-1].symbol != nil && NA[i-1].symbol === OA[j-1].symbol {
                    NA[i-1] = .Index(j-1)
                    OA[j-1] = .Index(i-1)
                }
            }
            i -= 1
        }
    }
}

public enum Reference {
    public final class Symbol {
        public var oldCounter = 0 // OC
        public var newCounter = 0 // NC
        public var oldIndex = 0 // OLNO
    }

    case Pointer(Symbol)
    case Index(Int)

    public var symbol: Symbol? {
        switch self {
        case let .Pointer(symbol): return symbol
        default: return nil
        }
    }

    public var index: Int? {
        switch self {
        case let .Index(index): return index
        default: return nil
        }
    }
}
