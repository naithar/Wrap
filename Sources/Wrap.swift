import Foundation
@_exported import Foundation.NSData

public protocol Wrappable: WrapConvertible, WrapSubscriptable, WrapCheckable {
    
}

public struct Value: Wrappable {
 
    public enum `Type` {
        case data(Data)
        case bool(Bool)
        case int(Int)
        case double(Double)
        case string(String)
        case array([Any])
        case dictionary([AnyHashable : Any])
        case unknown(Any)
    }
    
    public static let null = Value()
    
    fileprivate var type: Type = .unknown(NSNull())

    private init() {}

    public init(_ value: Any) {
        self.object = value
    }
}

extension Value {
    
    public fileprivate(set) var object: Any {
        get {
            switch self.type {
            case .data(let data):
                return data
            case .string(let string):
                return string
            case .bool(let bool):
                return bool
            case .int(let int):
                return int
            case .double(let double):
                return double
            case .array(let array):
                return array
            case .dictionary(let dictionary):
                return dictionary
            case .unknown(let value):
                return value
            }
        }
        set(object) {
            switch object {
            case let data as Data:
                self.type = .data(data)
            case let string as String:
                self.type = .string(string)
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
    
    public var data: Data? {
        switch self.type {
        case .data(let data):
            return data
        case .string(let string):
            return string.data(using: .utf8)
        case .int(let int):
            return String(int).data(using: .utf8)
        case .double(let double):
            return String(double).data(using: .utf8)
        case .unknown(let value as WrapConvertible):
            return value.data
        default:
            return nil
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
        case .string(let value):
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
        case .string(let value):
            return Double(value)
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
    
    public func `as`<T>(_ type: T.Type) -> T? {
        switch self.type {
        case .unknown(let value as WrapConvertible):
            return value.as(T.self)
        default:
            return self.object as? T
        }
    }
}

extension Value {
    
    public var isData: Bool {
        switch self.type {
        case .data:
            return true
        case .unknown(let value as WrapCheckable):
            return value.isData
        default:
            return false
        }
    }
    
    public var isBool: Bool {
        switch self.type {
        case .bool:
            return true
        case .unknown(let value as WrapCheckable):
            return value.isBool
        default:
            return false
        }
    }
    
    public var isInt: Bool {
        switch self.type {
        case .int:
            return true
        case .unknown(let value as WrapCheckable):
            return value.isInt
        default:
            return false
        }
    }
    
    public var isDouble: Bool {
        switch self.type {
        case .double:
            return true
        case .unknown(let value as WrapCheckable):
            return value.isDouble
        default:
            return false
        }
    }
    
    public var isString: Bool {
        switch self.type {
        case .string:
            return true
        case .unknown(let value as WrapCheckable):
            return value.isString
        default:
            return false
        }
    }
    
    public var isArray: Bool {
        switch self.type {
        case .array:
            return true
        case .unknown(let value as WrapCheckable):
            return value.isArray
        default:
            return false
        }
    }
    
    public var isDictionary: Bool {
        switch self.type {
        case .dictionary:
            return true
        case .unknown(let value as WrapCheckable):
            return value.isDictionary
        default:
            return false
        }
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
    
    public func `is`<T>(_ type: T.Type) -> Bool {
        switch self.type {
        case .unknown(let value as WrapCheckable):
            return value.is(T.self)
        default:
            return (self.object as? T) != nil
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
        case (.unknown(let value as WrapSubscriptable), _):
            return Value(value[keys])
        default:
            return .null
        }
    }
}
