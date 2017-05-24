import Vapor
import Validation

private let regex = "^.*(?=.{3,})(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[\\d\\X])(?=.*[^a-zA-Z\\d\\s:]).*$"
private let minLenght = 6

/*The password contains characters from at least three of the following four categories:

 English uppercase characters (A – Z)
 English lowercase characters (a – z)
 Base 10 digits (0 – 9)
 Non-alphanumeric (For example: !, $, #, or %)
 Unicode characters
 Minimum 6 
 */

public struct StrongPassword: Validator {

    public func validate(_ input: String) throws {
        guard input.range(of: regex, options: .regularExpression) != nil && input.count >= minLenght else {
            throw Abort(
                .badRequest,
                metadata: nil,
                reason: "Not strong password"
            )
        }
    }
}
