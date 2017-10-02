//
//  PHDiffTests.swift
//  PHDiffTests
//
//  Created by Andre Alves on 10/16/16.
//  Copyright © 2016 Andre Alves. All rights reserved.
//

import XCTest
@testable import PHDiff

final class PHDiffTests: XCTestCase {

    func testDiff() {
        var oldArray: [String] = []
        var newArray: [String] = []
        var steps: [DiffStep<String>] = []

        oldArray = ["a", "b", "c"]
        newArray = ["a", "b", "c"]
        steps = PHDiff.sortedSteps(fromArray: oldArray, toArray: newArray)
        XCTAssertTrue(oldArray.apply(steps: steps) == newArray)

        oldArray = []
        newArray = ["a", "b", "c", "d", "e"]
        steps = PHDiff.sortedSteps(fromArray: oldArray, toArray: newArray)
        XCTAssertTrue(oldArray.apply(steps: steps) == newArray)

        oldArray = ["a", "b", "c", "c", "c"]
        newArray = []
        steps = PHDiff.sortedSteps(fromArray: oldArray, toArray: newArray)
        XCTAssertTrue(oldArray.apply(steps: steps) == newArray)

        oldArray = ["a", "b", "c", "c", "c"]
        newArray = ["e", "b", "c", "d", "a"]
        steps = PHDiff.sortedSteps(fromArray: oldArray, toArray: newArray)
        XCTAssertTrue(oldArray.apply(steps: steps) == newArray)

        oldArray = ["p", "U", "b", "A", "5", "F"]
        newArray = ["O", "w", "Z", "U"]
        steps = PHDiff.sortedSteps(fromArray: oldArray, toArray: newArray)
        XCTAssertTrue(oldArray.apply(steps: steps) == newArray)

        oldArray = ["p", "b", "U", "A", "5", "F"]
        newArray = ["O", "w", "Z", "U"]
        steps = PHDiff.sortedSteps(fromArray: oldArray, toArray: newArray)
        XCTAssertTrue(oldArray.apply(steps: steps) == newArray)

        oldArray = ["x", "E", "g", "B", "f", "o", "3", "m"]
        newArray = ["j", "f", "L", "L", "m", "V", "g", "Q", "1"]
        steps = PHDiff.sortedSteps(fromArray: oldArray, toArray: newArray)
        XCTAssertTrue(oldArray.apply(steps: steps) == newArray)

        oldArray = ["j", "E", "g", "B", "f", "o", "3", "m"]
        newArray = ["j", "f", "L", "L", "m", "V", "g", "Q", "1"]
        steps = PHDiff.sortedSteps(fromArray: oldArray, toArray: newArray)
        XCTAssertTrue(oldArray.apply(steps: steps) == newArray)

        oldArray = ["a", "b", "c", "c", "c"]
        newArray = ["e", "b", "c", "d", "a"]
        steps = PHDiff.sortedSteps(fromArray: oldArray, toArray: newArray)
        XCTAssertTrue(oldArray.apply(steps: steps) == newArray)

        oldArray = ["a", "b", "c"]
        newArray = ["b", "c", "c"]
        steps = PHDiff.sortedSteps(fromArray: oldArray, toArray: newArray)
        XCTAssertEqual(steps, [ DiffStep.delete(value: "a", index: 0), DiffStep.insert(value: "c", index: 2) ])

        oldArray = ["a", "b", "c"]
        newArray = ["c", "a", "b"]
        steps = PHDiff.steps(fromArray: oldArray, toArray: newArray)
        XCTAssertEqual(steps, [ DiffStep.move(value: "c", fromIndex: 2, toIndex: 0)])

        oldArray = ["a", "b", "c"]
        newArray = ["b", "c", "a"]
        steps = PHDiff.steps(fromArray: oldArray, toArray: newArray)
        XCTAssertEqual(steps, [
            DiffStep.move(value: "b", fromIndex: 1, toIndex: 0),
            DiffStep.move(value: "c", fromIndex: 2, toIndex: 1),
        ])
    }

    func testDiffUpdate() {
        var oldArray: [TestUser] = []
        var newArray: [TestUser] = []
        var steps: [DiffStep<TestUser>] = []
        var expectedSteps: [DiffStep<TestUser>] = []

        oldArray = [TestUser(id: 1, name: "a"), TestUser(id: 2, name: "a")]
        newArray = [TestUser(id: 1, name: "a"), TestUser(id: 2, name: "A")]
        steps = PHDiff.sortedSteps(fromArray: oldArray, toArray: newArray)
        expectedSteps = [.update(value: TestUser(id: 2, name: "A"), index: 1)]
        XCTAssertTrue(steps == expectedSteps)
        XCTAssertTrue(oldArray.apply(steps: steps) == newArray, "simple update")

        oldArray = [TestUser(id: 1, name: "b")]
        newArray = [TestUser(id: 2, name: "a"), TestUser(id: 1, name: "B")]
        steps = PHDiff.sortedSteps(fromArray: oldArray, toArray: newArray)
        expectedSteps = [.update(value: TestUser(id: 1, name: "B"), index: 0), .insert(value: TestUser(id: 2, name: "a"), index: 0)]
        XCTAssertTrue(steps == expectedSteps)
        XCTAssertTrue(oldArray.apply(steps: steps) == newArray, "update uses old index")
    }

    func testRandomDiffs() {
        let numberOfTests = 1000

        for i in 1...numberOfTests {
            print("############### Random Diff Test \(i) ###############")
            let oldArray = randomArray(length: randomNumber(0..<500))
            let newArray = randomArray(length: randomNumber(0..<500))

            let steps = PHDiff.sortedSteps(fromArray: oldArray, toArray: newArray)
            let success = oldArray.apply(steps: steps) == newArray
            XCTAssertTrue(success)

            if !success {
                print("oldArray = \(oldArray)")
                print("newArray = \(newArray)")
                break
            }
        }
    }

    func testDiffPerformance() {
        let oldArray = randomArray(length: 1000)
        let newArray = randomArray(length: 1000)

        self.measure {
            let _ = PHDiff.sortedSteps(fromArray: oldArray, toArray: newArray)
        }
    }
}
