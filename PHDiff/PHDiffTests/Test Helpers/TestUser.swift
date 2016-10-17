//
//  TestUser.swift
//  PHDiff
//
//  Created by Andre Alves on 10/17/16.
//  Copyright © 2016 Andre Alves. All rights reserved.
//

import Foundation
@testable import PHDiff

struct TestUser: Diffable {
    let name: String
    let age: Int

    var diffIdentifier: String {
        return name
    }
}

func ==(lhs: TestUser, rhs: TestUser) -> Bool {
    return lhs.name == rhs.name && lhs.age == rhs.age
}
