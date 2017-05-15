import XCTest
import Foundation
@testable import Sugar

class StringSugarTests: XCTestCase {

    static let allTest = [
        ("testThatUrlEncodingWithDanishCharactersWorks", testThatUrlEncodingWithDanishCharactersWorks),
        ("testThatUrlEncodingWithSpacesWorks", testThatUrlEncodingWithSpacesWorks),
        ("testThatStrongPasswordValidatorWorks", testThatStrongPasswordValidatorWorks)
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

    func testThatStrongPasswordValidatorWorks() {
        XCTAssertThrowsError(try StrongPassword().validate("Password"))
        XCTAssertNoThrow(try StrongPassword().validate("password1!"))
    }
}



