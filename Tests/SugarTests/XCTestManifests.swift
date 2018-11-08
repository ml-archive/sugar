import XCTest

extension StrongPasswordValidatorTests {
    static let __allTests = [
        ("testThatItThrowsWhenSatisfyingNoRegexWithCustomDigitRegex", testThatItThrowsWhenSatisfyingNoRegexWithCustomDigitRegex),
        ("testThatItThrowsWhenSatisfyingOneRegex", testThatItThrowsWhenSatisfyingOneRegex),
        ("testThatItThrowsWhenSatisfyingOneRegexWithCustomLowerCharAndDigitRegex", testThatItThrowsWhenSatisfyingOneRegexWithCustomLowerCharAndDigitRegex),
        ("testThatItThrowsWhenSatisfyingOneRegexWithRequiredMatchesAtTwo", testThatItThrowsWhenSatisfyingOneRegexWithRequiredMatchesAtTwo),
        ("testThatItThrowsWhenSatisfyingTwoRegexes", testThatItThrowsWhenSatisfyingTwoRegexes),
        ("testThatItValidatesWhenSatisfyingOneRegexWithCustomDigitRegex", testThatItValidatesWhenSatisfyingOneRegexWithCustomDigitRegex),
        ("testThatItValidatesWhenSatisfyingOneRegexWithRequiredMatchesAtOne", testThatItValidatesWhenSatisfyingOneRegexWithRequiredMatchesAtOne),
        ("testThatItValidatesWhenSatisfyingTwoRegexWithCustomLowerCharAndDigitRegex", testThatItValidatesWhenSatisfyingTwoRegexWithCustomLowerCharAndDigitRegex),
        ("testThatItValidatesWhenUsingLowerCharUpperCharAndDigit", testThatItValidatesWhenUsingLowerCharUpperCharAndDigit),
        ("testThatItValidatesWhenUsingLowerCharUpperCharAndEmojiAsSpecialChar", testThatItValidatesWhenUsingLowerCharUpperCharAndEmojiAsSpecialChar),
        ("testThatItValidatesWhenUsingLowerCharUpperCharAndSpecialChar", testThatItValidatesWhenUsingLowerCharUpperCharAndSpecialChar),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(StrongPasswordValidatorTests.__allTests),
    ]
}
#endif
