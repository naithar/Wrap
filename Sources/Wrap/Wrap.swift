@_exported import Foundation

public protocol Wrappable: WrapConvertible, WrapSubscriptable, WrapCheckable {
    
}

public struct Wrap: Wrappable {
    
    public enum `Type` {
        case data(Data)
        case bool(Bool)
        case numeric(Numeric)
        case string(String)
        case array([Any])
        case dictionary([AnyHashable : Any])
        case unknown(Any)
    }
    
    public static let null = Wrap()
    
    fileprivate var type: Type = .unknown(NSNull())

    private init() {}

    public init(_ value: Any) {
        self.object = value
    }

    public fileprivate(set) var object: Any {
        get {
            switch self.type {
            case .data(let data):
                return data
            case .string(let string):
                return string
            case .bool(let bool):
                return bool
            case .numeric(let number):
                return number
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
            case let number as Numeric:
                self.type = .numeric(number)
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
        case .numeric(let number):
            return number.string.data(using: .utf8)
        case .unknown(let value as WrapConvertible):
            return value.data
        default:
            return nil
        }
    }
    
    public var bool: Bool? {
        switch self.type {
        case .data(let data):
            guard let string = String(data: data, encoding: .utf8) else { return nil }
            switch string.lowercased() {
            case "true":
                return true
            case "false":
                return false
            default:
                if let int = Int(string) {
                    return int != 0
                } else if let double = Double(string) {
                    return double != 0
                } else {
                    return nil
                }
            }
        case .bool(let value):
            return value
        case .numeric(let number):
            return number.int != 0
        case .string(let value):
            switch value.lowercased() {
            case "true":
                return true
            case "false":
                return false
            default:
                if let int = Int(value) {
                    return int != 0
                } else if let double = Double(value) {
                    return double != 0
                } else {
                    return nil
                }
            }
        case .unknown(let value as WrapConvertible):
            return value.bool
        default:
            return nil
        }
    }
    
    
    public var int: Int? {
        switch self.type {
        case .data(let value):
            guard let string = String(data: value, encoding: .utf8) else { return nil }
            return Int(string)
        case .numeric(let number):
            return number.int
        case .string(let value):
            return Int(value)
        case .unknown(let value as WrapConvertible):
            return value.int
        default:
            return nil
        }
    }
    
    public var uInt: UInt? {
        switch self.type {
        case .data(let value):
            guard let string = String(data: value, encoding: .utf8) else { return nil }
            return UInt(string)
        case .numeric(let number):
            return number.uInt
        case .string(let value):
            return UInt(value)
        case .unknown(let value as WrapConvertible):
            return value.uInt
        default:
            return nil
        }
    }
    
    
    public var double: Double? {
        switch self.type {
        case .data(let value):
            guard let string = String(data: value, encoding: .utf8) else { return nil }
            return Double(string)
        case .numeric(let number):
            return number.double
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
        case .data(let value):
            return String(data: value, encoding: .utf8)
        case .bool(let value):
            return value ? "true" : "false"
        case .numeric(let number):
            return number.string
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
            return value.as(T.self) ?? (self.object as? T)
        default:
            return self.object as? T
        }
    }
}

extension Wrap {
    
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
        case .numeric:
            return true
        case .unknown(let value as WrapCheckable):
            return value.isInt
        default:
            return false
        }
    }
    
    public var isUInt: Bool {
        switch self.type {
        case .numeric:
            return true
        case .unknown(let value as WrapCheckable):
            return value.isInt
        default:
            return false
        }
    }
    
    public var isDouble: Bool {
        switch self.type {
        case .numeric:
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
                || (self.object as? T) != nil
        default:
            return (self.object as? T) != nil
        }
    }

    public subscript(key: WrapKeyProtocol) -> Wrap {
        switch (self.type, key.key) {
        case (.array(let array), .index(let index)):
            guard index >= 0 && index < array.count else { return .null }
            return Wrap(array[index])
        case (.dictionary(let dictionary), .key(let key)):
            guard let value = dictionary[key] else { return .null }
            return Wrap(value)
        case (.unknown(let value as WrapConvertible), .index(let index)):
            guard let array = value.array,
                index >= 0 && index < array.count else { return .null }
            return Wrap(array[index])
        case (.unknown(let value as WrapConvertible), .key(let key)):
            guard let value = value.dictionary?[key] else { return .null }
            return Wrap(value)
        case (.unknown(let value as WrapSubscriptable), _):
            return Wrap(value.request(key: key))
        default:
            return .null
        }
    }
}
