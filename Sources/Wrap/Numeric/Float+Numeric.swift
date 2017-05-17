//
//  Float+Numeric.swift
//  Wrap
//
//  Created by Sergey Minakov on 17.05.17.
//
//

extension Float: Numeric {
    
    public var int: Int {
        return Int(self)
    }
    
    public var uInt: UInt {
        return UInt(self)
    }
    
    public var double: Double {
        return Double(self)
    }
}
