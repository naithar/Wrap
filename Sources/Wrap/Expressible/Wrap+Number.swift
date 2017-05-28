//
//  Wrap+Number.swift
//  Wrap
//
//  Created by Sergey Minakov on 28.05.17.
//
//

extension Value: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: Int) {
        self.init(value)
    }
}

extension Value: ExpressibleByFloatLiteral {
    
    public init(floatLiteral value: Double) {
        self.init(value)
    }
}
