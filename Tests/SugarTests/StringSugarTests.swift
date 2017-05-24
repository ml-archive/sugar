import XCTest
import Foundation
@testable import Sugar

class StringSugarTests: XCTestCase {

    static var allTests = [
        ("testThatUrlEncodingWithDanishCharactersWorks", testThatUrlEncodingWithDanishCharactersWorks),
        ("testThatUrlEncodingWithSpacesWorks", testThatUrlEncodingWithSpacesWorks),
        ]

    func testThatUrlEncodingWithDanishCharactersWorks() {
        let url = "æøå"
        let encoded = try! url.urlEncoded()
        XCTAssertEqual(encoded, "%C3%A6%C3%B8%C3%A5")
    }

    func testThatUrlEncodingWithSpacesWorks() {
        let url = "æ ø å"
        let encoded = try! url.urlEncoded()
        XCTAssertEqual(encoded, "%C3%A6%20%C3%B8%20%C3%A5")
    }
}


