import XCTest
@testable import Sugar

class SugarTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(Sugar().text, "Hello, World!")
    }


    static var allTests : [(String, (SugarTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
