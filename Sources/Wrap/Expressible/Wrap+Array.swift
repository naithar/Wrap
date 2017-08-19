//
//  Wrap+Array.swift
//  Wrap
//
//  Created by Sergey Minakov on 28.05.17.
//
//

extension Wrap: ExpressibleByArrayLiteral {
    
    public init(arrayLiteral elements: Any...) {
        self.init(elements)
    }
}
