import Validation

public struct PasswordRegex {
    public let pattern: String
    public let description: String

    public init(pattern: String, description: String) {
        self.pattern = pattern
        self.description = description
    }
}

extension Validator {
    public static func strongPassword(
        regexes: [PasswordRegex] = [
            PasswordRegex(
                pattern: "^.*[a-z].*$",
                description: "has a lowercase character"
            ),
            PasswordRegex(
                pattern: "^.*[A-Z].*$",
                description: "has a uppercase character"
            ),
            PasswordRegex(
                pattern: "^.*[0-9].*$",
                description: "has a digit"
            ),
            PasswordRegex(
                pattern: "^.*[^a-zA-Z0-9].*$",
                description: "has a special character (e.g. !@#$%^)"
            )
        ],
        requiredMatches: Int = 3
    ) -> Validator<String> {
        return StrongPasswordValidator<String>(
            regexes: regexes,
            requiredMatches: requiredMatches
        ).validator()
    }
}

/// Validates whether the string satisfies the given required number of regex matches.
fileprivate struct StrongPasswordValidator<T>: ValidatorType {
    /// See `ValidatorType`.
    var validatorReadable: String {
        return "satisfy \(requiredMatches) of the following requirements: \(regexes.requirements)"
    }

    let regexes: [PasswordRegex]
    let requiredMatches: Int

    init(regexes: [PasswordRegex], requiredMatches: Int) {
        self.regexes = regexes
        self.requiredMatches = requiredMatches
    }

    /// See `ValidatorType`.
    func validate(_ data: String) throws {
        let matchingRegexesCount = regexes
            .reduce(0, {
                $0 + ((data.range(of: $1.pattern, options: .regularExpression) == nil) ? 0 : 1)
            })

        guard matchingRegexesCount >= requiredMatches else {
            throw BasicValidationError(
                "does not satisfy \(requiredMatches) " +
                "of the following requirements: \(regexes.requirements)"
            )
        }
    }
}

fileprivate extension Sequence where Iterator.Element == PasswordRegex {
    var requirements: String {
        return self.map { $0.description }.joined(separator: ", ")
    }
}
