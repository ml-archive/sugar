import XCTest
import Validation
@testable import Sugar

class ValidatorsTests: XCTestCase {

    static let allTests = [
        ("testThatStrongPasswordValidatorWorks", testThatStrongPasswordValidatorWorks),
        ("testThatURLValidatorWorks", testThatURLValidatorWorks),
        ("testThatNumericValidatorWorks", testThatNumericValidatorWorks),
        ("testThatIPv4AddressValidatorWorks", testThatIPv4AddressValidatorWorks),
        ("testThatIPv6AddressValidatorWorks", testThatIPv6AddressValidatorWorks),
        ("testThatGenericIPAddressValidatorWorks", testThatGenericIPAddressValidatorWorks),
        ("testThatRequiredValidatorWorks", testThatRequiredValidatorWorks),
        ("testThatJSONValidatorWorks", testThatJSONValidatorWorks),
        ("testThatDifferentValidatorWorks", testThatDifferentValidatorWorks)
    ]

    func testThatStrongPasswordValidatorWorks() {
        XCTAssertThrowsError(try StrongPassword().validate("password"))  // Only one category
        XCTAssertThrowsError(try StrongPassword().validate("p4ssw0rd"))  // Only two categories
        XCTAssertThrowsError(try StrongPassword().validate("Aa1!"))      // Three categories, but too short
        XCTAssertNoThrow(try StrongPassword().validate("p@ssw0rd"))      // Three categories, and long enough
        XCTAssertNoThrow(try StrongPassword().validate("Qwer123"))      // Three categories, and long enough
        XCTAssertThrowsError(try StrongPassword(minLength: 10).validate("Qwer123"))      // Too short
        XCTAssertNoThrow(try StrongPassword(minMatchingRegexes: 3).validate("Qwer123"))      // 3/3 should work
        XCTAssertNoThrow(try StrongPassword(minMatchingRegexes: 2).validate("123_pp"))      // 2/3 should work
        XCTAssertNoThrow(try StrongPassword(minMatchingRegexes: 1).validate("!234DD"))      // 1/3 should work
        XCTAssertThrowsError(try StrongPassword(minMatchingRegexes: 4).validate("werQ1c"))  // 4/3 should not work
        XCTAssertThrowsError(try StrongPassword(regexes: [StrongPassword.specialCharRegex], minMatchingRegexes: 4).validate("aA1🔥🔥🔥"))  // Emoji as special char
    }

    func testThatURLValidatorWorks() {
        XCTAssertNoThrow(try URL().validate("ftp://www.website.com"))
        XCTAssertNoThrow(try URL().validate("https://www.website.com"))
        XCTAssertNoThrow(try URL().validate("http://www.url-with-querystring.com/?url=has-querystring"))
        XCTAssertThrowsError(try URL().validate("notvalidurl"))
        XCTAssertThrowsError(try URL().validate("http://www.web site.com"))
    }

    func testThatNumericValidatorWorks() {
        XCTAssertThrowsError(try Numeric().validate("notNumber"))
        XCTAssertNoThrow(try Numeric().validate("1337"))
        XCTAssertNoThrow(try Numeric().validate("1337.1337"))
    }

    func testThatIPv4AddressValidatorWorks() {
        XCTAssertNoThrow(try IPAddress.ipv4.validate("0.0.0.0"))
        XCTAssertNoThrow(try IPAddress.ipv4.validate("255.255.255.255"))
        XCTAssertThrowsError(try IPAddress.ipv4.validate("300.300.300.300"))   //  Values out of range
        XCTAssertThrowsError(try IPAddress.ipv4.validate("255.255.255"))       //  Missing values
    }

    func testThatIPv6AddressValidatorWorks() {
        XCTAssertNoThrow(try IPAddress.ipv6.validate("::"))
        XCTAssertNoThrow(try IPAddress.ipv6.validate("2001::25de::cade"))
        XCTAssertNoThrow(try IPAddress.ipv6.validate("2001:0DB8::1428:57ab"))
        XCTAssertNoThrow(try IPAddress.ipv6.validate("2001:0DB8:0000:0000:0000:0000:1428:57ab"))
        XCTAssertThrowsError(try IPAddress.ipv6.validate("255.255.255.255"))
        XCTAssertThrowsError(try IPAddress.ipv6.validate("xxxx:"))
    }

    func testThatGenericIPAddressValidatorWorks() {
        XCTAssertNoThrow(try IPAddress.ip.validate("0.0.0.0"))
        XCTAssertNoThrow(try IPAddress.ip.validate("255.255.255.255"))
        XCTAssertNoThrow(try IPAddress.ip.validate("2001:0DB8::1428:57ab"))
        XCTAssertNoThrow(try IPAddress.ip.validate("::"))
    }

    func testThatRequiredValidatorWorks() {
        XCTAssertThrowsError(try Required().validate(""))
        XCTAssertThrowsError(try Required().validate([]))
        XCTAssertThrowsError(try Required().validate(nil))
        XCTAssertNoThrow(try Required().validate("notEmpty"))
        XCTAssertNoThrow(try Required().validate(["notEmpty"]))
        XCTAssertNoThrow(try Required().validate(1))
    }

    func testThatJSONValidatorWorks() {
        XCTAssertNoThrow(try JSONValidator().validate(
            "{\n" +
                "\"boolean\": true,\n" +
                "\"object\": {\n" +
                "\"a\": \"b\",\n" +
                "\"c\": \"d\",\n" +
                "\"e\": \"f\"\n" +
                "},\n" +
                "\"array\": [1 , 2],\n" +
                "\"string\": \"Hello World\"\n" +
            "}"
            ))
        XCTAssertThrowsError(try JSONValidator().validate("{notAValidJSON: notValid}"))
    }

    func testThatDifferentValidatorWorks() {
        let collection = 1
        XCTAssertNoThrow(try collection.tested(by: Different(2)))
        XCTAssertThrowsError(try collection.tested(by: Different(1)))
    }

}

