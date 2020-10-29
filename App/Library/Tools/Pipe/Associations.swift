//
//  Associations.swift
//
//  Created by Alex Kozin on 12.10.2020.
//  Copyright © 2020 El Machine. All rights reserved.
//

import Foundation

struct Associations {
    
    private static var objects = [String: [String: Any]]()
    
    fileprivate static func associate(_ value: Any?, for key: String, on object: CustomStringConvertible) {
        let objKey = object.description
        
        var values = objects[objKey] ?? [String: Any]()
        values[key] = value
        
        objects[objKey] = values
    }
    
    fileprivate static func association(for key: String, on object: CustomStringConvertible) -> Any? {
        objects[object.description]?[key]
    }
    
}

protocol Associatable {
    
    func association<T>(for key: String, constructor: ()->(T)) -> T
    func association<T>(for key: String) -> T?
    
    @discardableResult
    func associate<T>(_ value: T?, for key: String) -> T?
    
    @discardableResult
    func associate<T>(_ value: T, for key: String) -> T
    
}

extension Associatable {
    
    func association<T>(for key: String, constructor: ()->(T)) -> T {
        association(for: key) ?? {
            associate(constructor(), for: key)
        }()
    }
    
    func association<T>(for key: String) -> T? {
        Associations.association(for: key, on: String(describing: self)) as? T
    }
    
    func associate<T>(_ value: T?, for key: String) -> T? {
        Associations.associate(value, for: key, on: String(describing: self))
        return value
    }
    
    func associate<T>(_ value: T, for key: String) -> T {
        Associations.associate(value, for: key, on: String(describing: self))
        return value
    }
    
}
