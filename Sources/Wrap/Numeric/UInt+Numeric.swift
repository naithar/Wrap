//
//  UInt+Numeric.swift
//  Wrap
//
//  Created by Sergey Minakov on 17.05.17.
//
//

extension UInt8: Numeric {
    
    public var int: Int {
        return Int(self)
    }
    
    public var uInt: UInt {
        return UInt(self)
    }
    
    public var double: Double {
        return Double(self)
    }
    
    public var string: String {
        return String(describing: self)
    }
}

extension UInt16: Numeric {
    
    public var int: Int {
        return Int(self)
    }
    
    public var uInt: UInt {
        return UInt(self)
    }
    
    public var double: Double {
        return Double(self)
    }
    
    public var string: String {
        return String(describing: self)
    }
}

extension UInt32: Numeric {
    
    public var int: Int {
        return Int(self)
    }
    
    public var uInt: UInt {
        return UInt(self)
    }
    
    public var double: Double {
        return Double(self)
    }
    
    public var string: String {
        return String(describing: self)
    }
}

extension UInt64: Numeric {
    
    public var int: Int {
        return Int(self)
    }
    
    public var uInt: UInt {
        return UInt(self)
    }
    
    public var double: Double {
        return Double(self)
    }
    
    public var string: String {
        return String(describing: self)
    }
}

extension UInt: Numeric {
    
    public var int: Int {
        return Int(self)
    }
    
    public var uInt: UInt {
        return self
    }
    
    public var double: Double {
        return Double(self)
    }
    
    public var string: String {
        return String(describing: self)
    }
}
