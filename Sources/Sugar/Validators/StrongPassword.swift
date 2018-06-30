import Vapor
import Validation

/*The password contains characters from at least three of the following four categories:

 English uppercase characters (A – Z)
 English lowercase characters (a – z)
 Base 10 digits (0 – 9)
 Non-alphanumeric (For example: !, $, #, or %)

 */

public struct StrongPassword: Validator {

    static let lowerCaseRegex = "^.*[a-z].*$"
    static let upperCaseRegex = "^.*[A-Z].*$"
    static let digitsRegex = "^.*[0-9].*$"
    static let specialCharRegex = "^.*[^a-zA-Z0-9].*$"

    static let standardRegexes = [lowerCaseRegex, upperCaseRegex, digitsRegex, specialCharRegex]

    internal let minLength: Int
    internal let minMatchingRegexes: Int
    internal let regexes: [String]
    internal var errorDescription: String?

    public init(
        minLength: Int = 6,
        regexes: [String] = standardRegexes,
        minMatchingRegexes: Int = 3,
        errorDescription: String? = nil)
    {
        self.minLength = minLength
        self.regexes = regexes
        self.minMatchingRegexes = minMatchingRegexes
        self.errorDescription = errorDescription
    }

    public func validate(_ input: String) throws {

        let matchingRegexesCount = regexes
            .reduce(0, {
                $0 + ((input.range(of: $1, options: .regularExpression) == nil) ? 0 : 1)
            })

        guard input.count >= minLength, matchingRegexesCount >= minMatchingRegexes else {
            throw error(errorDescription ??
                "Password is not strong enough. It must be be at least \(minLength) characters long and contain \(minMatchingRegexes) of these: a number, a capital letter, a small letter or a special character.")
        }
    }
}
