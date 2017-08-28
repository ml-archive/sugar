import Vapor
import Validation

public struct Numeric: Validator {

    public func validate(_ input: String) throws {
        guard Double(input) != nil else {
            throw error("The value \"\(input)\" is not numeric.")
        }
    }
}
