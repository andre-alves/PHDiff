//
//  Diffable.swift
//  PHDiff
//
//  Created by Andre Alves on 10/13/16.
//  Copyright © 2016 Andre Alves. All rights reserved.
//

import Foundation

/// A diffable object must be Equatable and provide one hashable identifier.
public protocol Diffable: Equatable {
    associatedtype HashType: Hashable

    /// The hashable identifier. This is used to map each object and find updates.
    /// If your object conforms to Hashable, this property is provided automatically.
    var diffIdentifier: HashType { get }
}

public extension Diffable where Self: Hashable {
    public var diffIdentifier: Self {
        return self
    }
}

extension String: Diffable {}
extension Int: Diffable {}
extension Int64: Diffable {}
extension Int32: Diffable {}
extension Int16: Diffable {}
extension Int8: Diffable {}
extension Double: Diffable {}
extension Float: Diffable {}
extension NSObject: Diffable {}
