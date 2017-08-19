//
//  Wrap+Dictionary.swift
//  Wrap
//
//  Created by Sergey Minakov on 28.05.17.
//
//

extension Wrap: ExpressibleByDictionaryLiteral {
    
    public init(dictionaryLiteral elements: (AnyHashable, Any)...) {
        self.init(elements.reduce([AnyHashable : Any]()) { dictionary, value in
            var dictionary = dictionary
            dictionary[value.0] = value.1
            return dictionary
        })
    }
}
