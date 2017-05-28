//
//  Wrap+String.swift
//  Wrap
//
//  Created by Sergey Minakov on 28.05.17.
//
//

extension Value: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: String) {
        self.init(value)
    }
    
    public init(unicodeScalarLiteral value: UnicodeScalar) {
        self.init(String(value))
    }
    
    public init(extendedGraphemeClusterLiteral value: Character) {
        self.init(String(value))
    }
}
