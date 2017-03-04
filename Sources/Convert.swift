//
//  Convert.swift
//  KituraQuery
//
//  Created by Sergey Minakov on 03.03.17.
//
//

import Foundation

public protocol WrapConvertible {
    
    var object: Any { get }
    
    var bool: Bool? { get }
    
    var int: Int? { get }
    
    var double: Double? { get }
    
    var string: String? { get }
    
    var array: [Any]? { get }
    
    var dictionary: [AnyHashable : Any]? { get }
    
    func `as`<T>(_ type: T.Type) -> T?
}

public protocol WrapCheckable {
    
    var object: Any { get }
    
    var isBool: Bool { get }
    var isInt: Bool { get }
    var isDouble: Bool { get }
    var isString: Bool { get }
    var isArray: Bool { get }
    var isDictionary: Bool { get }
    var isNull: Bool { get }
    
    func `is`<T>(_ type: T.Type) -> Bool
}

extension WrapConvertible {
    
    public func `as`<T>(_ type: T.Type) -> T? {
        return self.object as? T
    }
}

extension WrapCheckable {
    
    public func `is`<T>(_ type: T.Type) -> Bool {
        return type(of: self.object) == T.self
    }
}
