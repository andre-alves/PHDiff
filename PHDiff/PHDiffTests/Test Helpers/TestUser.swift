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
    let id: Int
    let name: String

    var diffIdentifier: Int {
        return id
    }
}

func ==(lhs: TestUser, rhs: TestUser) -> Bool {
    return lhs.id == rhs.id && lhs.name == rhs.name
}
