//
//  Wrap+Bool.swift
//  Wrap
//
//  Created by Sergey Minakov on 28.05.17.
//
//

extension Wrap: ExpressibleByBooleanLiteral {
    
    public init(booleanLiteral value: Bool) {
        self.init(value)
    }
}
