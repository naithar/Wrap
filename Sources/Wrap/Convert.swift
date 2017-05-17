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
    
    var data: Data? { get }
    
    var bool: Bool? { get }
    
    var int: Int? { get }
    
    var uInt: UInt? { get }
    
    var double: Double? { get }
    
    var string: String? { get }
    
    var array: [Any]? { get }
    
    var dictionary: [AnyHashable : Any]? { get }
    
    func `as`<T>(_ type: T.Type) -> T?
}


extension WrapConvertible {
    
    public func `as`<T>(_ type: T.Type) -> T? {
        return self.object as? T
    }
}

