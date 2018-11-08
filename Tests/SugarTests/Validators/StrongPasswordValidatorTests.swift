import Sugar
import Vapor
import XCTest

final class StrongPasswordValidatorTests: XCTestCase {

    // MARK: Default behaviour

    func testThatItThrowsWhenSatisfyingOneRegex() {
        let password = "password" // Lower char regex satisfied
        let validator = Validator<String>.strongPassword()
        XCTAssertThrowsError(try validator.validate(password))
    }

    func testThatItThrowsWhenSatisfyingTwoRegexes() {
        let password = "p4ssw0rd" // Lower char and digit regex satisfied
        let validator = Validator<String>.strongPassword()
        XCTAssertThrowsError(try validator.validate(password))
    }

    func testThatItValidatesWhenUsingLowerCharUpperCharAndDigit() {
        let password = "P4ssw0rd" // Lower char, upper char and digit regex satisfied
        let validator = Validator<String>.strongPassword()
        XCTAssertNoThrow(try validator.validate(password))
    }

    func testThatItValidatesWhenUsingLowerCharUpperCharAndSpecialChar() {
        let password = "Password#" // Lower char, upper char and special char regex satisfied
        let validator = Validator<String>.strongPassword()
        XCTAssertNoThrow(try validator.validate(password))
    }

    func testThatItValidatesWhenUsingLowerCharUpperCharAndEmojiAsSpecialChar() {
        let password = "Password🔥" // Lower char, upper char and special char regex satisfied
        let validator = Validator<String>.strongPassword()
        XCTAssertNoThrow(try validator.validate(password))
    }

    // MARK: Overriding required matches

    func testThatItThrowsWhenSatisfyingOneRegexWithRequiredMatchesAtTwo() {
        let password = "password" // Lower char regex satisfied
        let validator = Validator<String>.strongPassword(requiredMatches: 2)
        XCTAssertThrowsError(try validator.validate(password))
    }

    func testThatItValidatesWhenSatisfyingOneRegexWithRequiredMatchesAtOne() {
        let password = "password" // Lower char regex satisfied
        let validator = Validator<String>.strongPassword(requiredMatches: 1)
        XCTAssertNoThrow(try validator.validate(password))
    }

    // MARK: Overriding regex patterns

    func testThatItThrowsWhenSatisfyingNoRegexWithCustomDigitRegex() {
        let digitRegex = PasswordRegex(pattern: "^.*[0-9].*$", description: "has a digit")
        let password = "password"
        let validator = Validator<String>.strongPassword(regexes: [digitRegex])
        XCTAssertThrowsError(try validator.validate(password))
    }

    func testThatItValidatesWhenSatisfyingOneRegexWithCustomDigitRegex() {
        let digitRegex = PasswordRegex(pattern: "^.*[0-9].*$", description: "has a digit")
        let password = "pa2ssword" // Digit regex satisfied
        let validator = Validator<String>.strongPassword(
            regexes: [digitRegex, digitRegex, digitRegex] // 3 is default required matches
        )
        XCTAssertNoThrow(try validator.validate(password))
    }

    // MARK: Overriding required matches and regex patterns

    func testThatItThrowsWhenSatisfyingOneRegexWithCustomLowerCharAndDigitRegex() {
        let digitRegex = PasswordRegex(pattern: "^.*[0-9].*$", description: "has a digit")
        let lowerCharRegex = PasswordRegex(
            pattern: "^.*[a-z].*$",
            description: "has a lowercase character"
        )
        let password = "Password" // Lower char regex satisfied
        let validator = Validator<String>.strongPassword(
            regexes: [digitRegex, lowerCharRegex], requiredMatches: 2
        )
        XCTAssertThrowsError(try validator.validate(password))
    }

    func testThatItValidatesWhenSatisfyingTwoRegexWithCustomLowerCharAndDigitRegex() {
        let digitRegex = PasswordRegex(pattern: "^.*[0-9].*$", description: "has a digit")
        let lowerCharRegex = PasswordRegex(
            pattern: "^.*[a-z].*$",
            description: "has a lowercase character"
        )
        let password = "Password1" // Lower char and digit regex satisfied
        let validator = Validator<String>.strongPassword(
            regexes: [digitRegex, lowerCharRegex], requiredMatches: 2
        )
        XCTAssertNoThrow(try validator.validate(password))
    }
}
