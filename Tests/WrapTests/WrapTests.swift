import XCTest
@testable import Wrap

class WrapTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(Wrap().text, "Hello, World!")
    }


    static var allTests : [(String, (WrapTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
