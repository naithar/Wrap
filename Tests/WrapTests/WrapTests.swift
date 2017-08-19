import XCTest
@testable import Wrap

class WrapTests: XCTestCase {
    
    func testExample() {
        
        var value = Wrap(10)
        
        XCTAssertEqual(10, value.int)
        XCTAssertEqual(10.0, value.double)
        XCTAssertEqual("10", value.string)
        XCTAssertEqual(true, value.bool)
        
        value = Wrap("10")
        
        XCTAssertEqual(10, value.int)
        XCTAssertEqual(10.0, value.double)
        XCTAssertEqual("10", value.string)
        XCTAssertEqual(true, value.bool)
        
        value = Wrap("sa")
        
        XCTAssertEqual("sa", value.string)
        XCTAssertNil(value.bool)
        
        value = Wrap([1, 2, 3])
        
        XCTAssertNotNil(value.array)
        XCTAssertEqual(1, value[0].int)
        XCTAssertEqual(2, value[1].int)
        XCTAssertEqual(3, value[2].int)
        
        value = Wrap(["a" : 1, "b" : 2, "c" : 3])
        
        XCTAssertNotNil(value.dictionary)
        XCTAssertEqual(1, value["a"].int)
        XCTAssertEqual(2, value["b"].int)
        XCTAssertEqual(3, value["c"].int)
        
        value = Wrap(["a" : 1, "b" : 2, "c" : [1, 2, 3]])
        
        XCTAssertNotNil(value.dictionary)
        XCTAssertEqual(1, value["a"].int)
        XCTAssertEqual(2, value["b"].int)
        XCTAssertNotNil(value["c"].array)
        XCTAssertEqual(1, value["c", 0].int)
        
        value = Wrap(["a" : 1, "b" : 2, "c" : ["a" : 1, "b" : 2, "c" : [1, 2, 3]]])
        
        XCTAssertNotNil(value.dictionary)
        XCTAssertEqual(1, value["a"].int)
        XCTAssertEqual(2, value["b"].int)
        XCTAssertNotNil(value["c"].dictionary)
        XCTAssertEqual(1, value["c", "a"].int)
        XCTAssertNotNil(value["c", "c"].array)
        XCTAssertEqual(1, value["c", "c", 0].int)
    }
    
    func testExpressible() {
        var value: Wrap = 10
        
        XCTAssertEqual(10, value.int)
        XCTAssertEqual(10.0, value.double)
        XCTAssertEqual("10", value.string)
        XCTAssertEqual(true, value.bool)
        
        value = "10"
        
        XCTAssertEqual(10, value.int)
        XCTAssertEqual(10.0, value.double)
        XCTAssertEqual("10", value.string)
        XCTAssertEqual(true, value.bool)
        
        value = "sa"
        
        XCTAssertEqual("sa", value.string)
        XCTAssertNil(value.bool)
        
        value = [1, 2, 3]
        
        XCTAssertNotNil(value.array)
        XCTAssertEqual(1, value[0].int)
        XCTAssertEqual(2, value[1].int)
        XCTAssertEqual(3, value[2].int)
        
        value = ["a" : 1, "b" : 2, "c" : 3]
        
        XCTAssertNotNil(value.dictionary)
        XCTAssertEqual(1, value["a"].int)
        XCTAssertEqual(2, value["b"].int)
        XCTAssertEqual(3, value["c"].int)
        
        value = ["a" : 1, "b" : 2, "c" : [1, 2, 3]]
        
        XCTAssertNotNil(value.dictionary)
        XCTAssertEqual(1, value["a"].int)
        XCTAssertEqual(2, value["b"].int)
        XCTAssertNotNil(value["c"].array)
        XCTAssertEqual(1, value["c", 0].int)
        
        value = ["a" : 1, "b" : 2, "c" : ["a" : 1, "b" : 2, "c" : [1, 2, 3]]]
        
        XCTAssertNotNil(value.dictionary)
        XCTAssertEqual(1, value["a"].int)
        XCTAssertEqual(2, value["b"].int)
        XCTAssertNotNil(value["c"].dictionary)
        XCTAssertEqual(1, value["c", "a"].int)
        XCTAssertNotNil(value["c", "c"].array)
        XCTAssertEqual(1, value["c", "c", 0].int)
    }

    static var allTests : [(String, (WrapTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
            ("testExpressible", testExpressible),
        ]
    }
}
