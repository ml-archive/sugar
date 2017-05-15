import Vapor

private let regex = "^.*(?=.{3,})(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[\\d\\X])(?=.*[!$#%]).*$"
/*The password contains characters from at least three of the following five categories:

 English uppercase characters (A – Z)
 English lowercase characters (a – z)
 Base 10 digits (0 – 9)
 Non-alphanumeric (For example: !, $, #, or %)
 Unicode characters*/

public struct StrongPassword {
    public init() {}

    public func validate(_ input: String) throws {
        guard input.range(of: regex, options: .regularExpression) != nil else {
            throw Abort(
                .badRequest,
                metadata: nil,
                reason: "Not strong password"
            )
        }
    }
}
