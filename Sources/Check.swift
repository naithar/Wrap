//
//  Check.swift
//  KituraQuery
//
//  Created by Sergey Minakov on 04.03.17.
//
//

import Foundation

public protocol WrapCheckable {
    
    var object: Any { get }
    
    var isData: Bool { get }
    var isBool: Bool { get }
    var isInt: Bool { get }
    var isDouble: Bool { get }
    var isString: Bool { get }
    var isArray: Bool { get }
    var isDictionary: Bool { get }
    var isNull: Bool { get }
    
    func `is`<T>(_ type: T.Type) -> Bool
}

extension WrapCheckable {
    
    public func `is`<T>(_ type: T.Type) -> Bool {
        return type(of: self.object) == T.self
    }
}
