//
//  PHDiff.swift
//  PHDiff
//
//  Created by Andre Alves on 10/13/16.
//  Copyright © 2016 Andre Alves. All rights reserved.
//

// Based on Paul Heckel's paper: A technique for isolating differences between files (1978).

import Foundation

public struct PHDiff {
    /// Creates steps (Inserts, Deletes, Moves and Updates) for batch operations.
    /// Can be used for UITableView, UICollectionView batch updates.
    /// Complexity: O(n+m) where n is fromArray.count and m is toArray.count.
    public static func steps<T: Diffable>(fromArray: [T], toArray: [T]) -> [DiffStep<T>] {
        // Creates and setups one context.
        let context = DiffContext<T>(fromArray: fromArray, toArray: toArray)

        var steps: [DiffStep<T>] = []
        var deleteOffsets = Array(repeating: 0, count: fromArray.count)
        var runningOffset = 0

        // Iterate old array records checking for deletes
        // Incremement offset for each delete
        for (j, ref) in context.OA.enumerated() {
            deleteOffsets[j] = runningOffset
            if ref.symbol != nil {
                steps.append(.delete(value: context.fromArray[j], index: j))
                runningOffset += 1
            }
        }

        // Reset and track offsets from inserted items to calculate where items have moved
        runningOffset = 0

        // Find inserts and moves
        for (i, ref) in context.NA.enumerated() {
            if let j = ref.index {
                // Check if there was a update
                if context.toArray[i] != context.fromArray[j] {
                    steps.append(.update(value: context.toArray[i], index: i))
                }

                // Calculate the offset and determine if there was a move
                // If the indexes match, ignore the index
                let insertOffset = runningOffset
                let deleteOffset = deleteOffsets[j]
                if (j - deleteOffset + insertOffset) != i {
                    steps.append(.move(value: context.toArray[i], fromIndex: j, toIndex: i))
                }
            } else {
                steps.append(.insert(value: context.toArray[i], index: i))
                runningOffset += 1
            }
        }

        return steps
    }

    /// Creates sorted steps (Inserts, Deletes and Updates) needed to transform fromArray to toArray.
    /// Complexity: O(n+m+d) where n is fromArray.count, m is toArray.count and d is the number of changes.
    public static func sortedSteps<T: Diffable>(fromArray: [T], toArray: [T]) -> [DiffStep<T>] {
        var insertions: [DiffStep<T>] = []
        var updates: [DiffStep<T>] = []
        var indexedDeletions: [[DiffStep<T>]] = Array(repeating: [], count: fromArray.count)

        let unsortedSteps = steps(fromArray: fromArray, toArray: toArray)

        for step in unsortedSteps {
            switch step {
            case .insert:
                insertions.append(step)

            case let .delete(_, fromIndex):
                indexedDeletions[fromIndex].append(step)

            case let .move(value, fromIndex, toIndex):
                // Convert Move to Insert + Delete
                insertions.append(.insert(value: value, index: toIndex))
                indexedDeletions[fromIndex].append(.delete(value: value, index: fromIndex))

            case .update:
                updates.append(step)
            }
        }

        // Insertions need to be sorted asc, batchUpdates already does that.
        // insertions.sort { $0.index < $1.index }

        // Deletions need to be sorted desc.
        let deletions = indexedDeletions.flatMap { $0.first }.reversed()

        return deletions + insertions + updates
    }
}
