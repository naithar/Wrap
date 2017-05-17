//
//  NSNumber+Numeric.swift
//  Wrap
//
//  Created by Sergey Minakov on 17.05.17.
//
//

import Foundation

extension NSNumber: Numeric {
    
    public var int: Int {
        return self.intValue
    }
    
    public var uInt: UInt {
        return self.uintValue
    }
    
    public var double: Double {
        return self.doubleValue
    }
}
