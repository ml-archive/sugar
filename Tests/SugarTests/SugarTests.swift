import XCTest
@testable import Sugar

class SugarTests: XCTestCase {
    func testExample() throws {
        XCTAssertTrue(true)
    }

    static var allTests : [(String, (SugarTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}