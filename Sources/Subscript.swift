//
//  Subscript.swift
//  KituraQuery
//
//  Created by Sergey Minakov on 03.03.17.
//
//

import Foundation

public enum WrapKey {
    
    /// Subscript key based on Int
    case index(Int)
    
    /// Subscript key based on String
    case key(String)
}

public protocol WrapKeyProtocol {
    
    var key: WrapKey { get }
}

extension Int: WrapKeyProtocol {
    
    public var key: WrapKey {
        return .index(self)
    }
}

extension String: WrapKeyProtocol {
    
    public var key: WrapKey {
        return .key(self)
    }
}

public protocol WrapSubscriptable {
    
    subscript(key: WrapKeyProtocol) -> Self { get }
}

extension WrapSubscriptable {
    
    public subscript(keys: WrapKeyProtocol...) -> Self {
        return self[keys]
    }
    public subscript(keys: [WrapKeyProtocol]) -> Self {
        return keys.reduce(self) { $0[$1] }
    }
}
