//
//  Diffable.swift
//  PHDiff
//
//  Created by Andre Alves on 10/13/16.
//  Copyright © 2016 Andre Alves. All rights reserved.
//

import Foundation

public protocol Diffable: Equatable {
    associatedtype HashType: Hashable

    var diffIdentifier: HashType { get }
}

public extension Diffable where Self: Hashable {
    public var diffIdentifier: Self {
        return self
    }
}

extension String: Diffable {}
extension Int: Diffable {}
extension Double: Diffable {}
extension Float: Diffable {}
extension NSObject: Diffable {}
