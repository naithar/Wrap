//
//  Wrap+Number.swift
//  Wrap
//
//  Created by Sergey Minakov on 28.05.17.
//
//

extension Wrap: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: Int) {
        self.init(value)
    }
}

extension Wrap: ExpressibleByFloatLiteral {
    
    public init(floatLiteral value: Double) {
        self.init(value)
    }
}
