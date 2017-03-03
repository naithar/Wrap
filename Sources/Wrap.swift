import Foundation

public protocol Wrappable: WrapConvertible, WrapSubscriptable, WrapCheckable {
    
}

public struct Value: Wrappable {
 
    public enum `Type` {
        case bool(Bool)
        case int(Int)
        case double(Double)
        case string(String)
        case array([Any])
        case dictionary([AnyHashable : Any])
        case unknown(Any)
    }
    
    public static let null = Value()
    
    fileprivate var _object: Any = NSNull()
    fileprivate var type: Type = .unknown(NSNull())

    private init() {}

    public init(_ value: Any) {
        self.object = value
    }
}

extension Value {
    
    public fileprivate(set) var object: Any {
        get {
            return self._object
        }
        set {
            self._object = newValue
            
            switch self._object {
            case let string as String:
                if let int = Int(string) {
                    self.type = .int(int)
                } else if let double = Double(string) {
                    self.type = .double(double)
                } else {
                    self.type = .string(string)
                }
            case let int as Int:
                self.type = .int(int)
            case let double as Double:
                self.type = .double(double)
            case let bool as Bool:
                self.type = .bool(bool)
            case let array as [Any]:
                self.type = .array(array)
            case let dictionary as [AnyHashable : Any]:
                self.type = .dictionary(dictionary)
            default:
                self.type = .unknown(object)
            }
        }
    }
    
    public var bool: Bool? {
        switch self.type {
        case .bool(let value):
            return value
        case .int(let value):
            return value != 0
        case .string(let value):
            switch value.lowercased() {
            case "true":
                return true
            case "false":
                return false
            default:
                return nil
            }
        case .unknown(let value as WrapConvertible):
            return value.bool
        default:
            return nil
        }
    }
    
    
    public var int: Int? {
        switch self.type {
        case .int(let value):
            return value
        case .double(let value):
            return Int(value)
        case .unknown(let value as WrapConvertible):
            return value.int
        default:
            return nil
        }
    }
    
    
    public var double: Double? {
        switch self.type {
        case .int(let value):
            return Double(value)
        case .double(let value):
            return value
        case .unknown(let value as WrapConvertible):
            return value.double
        default:
            return nil
        }
    }
    
    
    public var string: String? {
        switch self.type {
        case .bool(let value):
            return value ? "true" : "false"
        case .int(let value):
            return String(value)
        case .double(let value):
            return String(value)
        case .string(let value):
            return value
        case .unknown(let value as WrapConvertible):
            return value.string
        default:
            return nil
        }
    }
    
    
    public var array: [Any]? {
        switch self.type {
        case .array(let value):
            return value
        case .unknown(let value as WrapConvertible):
            return value.array
        default:
            return nil
        }
    }
    
    
    public var dictionary: [AnyHashable : Any]? {
        switch self.type {
        case .dictionary(let value):
            return value
        case .unknown(let value as WrapConvertible):
            return value.dictionary
        default:
            return nil
        }
    }
    
    
}

extension Value {
    
    public var isBool: Bool {
        return self.bool != nil
    }
    public var isInt: Bool {
        return self.int != nil
    }
    public var isDouble: Bool {
        return self.double != nil
    }
    public var isString: Bool {
        return self.string != nil
    }
    public var isArray: Bool {
        return self.array != nil
    }
    
    public var isDictionary: Bool {
        return self.dictionary != nil
    }
    
    public var isNull: Bool {
        switch self.type {
        case .unknown(_ as NSNull):
            return true
        case .unknown(let value as WrapCheckable):
            return value.isNull
        default:
            return false
        }
    }
}

extension Value {
    
    public subscript(keys: WrapKeyProtocol) -> Value {
        switch (self.type, keys.key) {
        case (.array(let array), .index(let index)):
            guard index >= 0 && index < array.count else { return .null }
            return Value(array[index])
        case (.dictionary(let dictionary), .key(let key)):
            guard let value = dictionary[key] else { return .null }
            return Value(value)
        default:
            return .null
        }
    }
}
