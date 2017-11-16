//
//  Double+Numeric.swift
//  Wrap
//
//  Created by Sergey Minakov on 17.05.17.
//
//

extension Double: Numeric {
    
    public var int: Int {
        return Int(self)
    }
    
    public var uInt: UInt {
        return UInt(self)
    }
    
    public var double: Double {
        return self
    }
    
    public var string: String {
        return String(describing: self)
    }
}
