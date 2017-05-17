//
//  Int+Numeric.swift
//  Wrap
//
//  Created by Sergey Minakov on 17.05.17.
//
//

extension Int8: Numeric {
    
    public var int: Int {
        return Int(self)
    }
    
    public var uInt: UInt {
        guard self >= 0 else { return 0 }
        return UInt(self)
    }
    
    public var double: Double {
        return Double(self)
    }
    
    public var string: String {
        return String(describing: self)
    }
}

extension Int16: Numeric {
    
    public var int: Int {
        return Int(self)
    }
    
    public var uInt: UInt {
        guard self >= 0 else { return 0 }
        return UInt(self)
    }
    
    public var double: Double {
        return Double(self)
    }
    
    public var string: String {
        return String(describing: self)
    }
}

extension Int32: Numeric {
    
    public var int: Int {
        return Int(self)
    }
    
    public var uInt: UInt {
        guard self >= 0 else { return 0 }
        return UInt(self)
    }
    
    public var double: Double {
        return Double(self)
    }
    
    public var string: String {
        return String(describing: self)
    }
}

extension Int64: Numeric {
    
    public var int: Int {
        return Int(self)
    }
    
    public var uInt: UInt {
        guard self >= 0 else { return 0 }
        return UInt(self)
    }
    
    public var double: Double {
        return Double(self)
    }
    
    public var string: String {
        return String(describing: self)
    }
}

extension Int: Numeric {
    
    public var int: Int {
        return self
    }
    
    public var uInt: UInt {
        guard self >= 0 else { return 0 }
        return UInt(self)
    }
    
    public var double: Double {
        return Double(self)
    }
    
    public var string: String {
        return String(describing: self)
    }
}
