import Vapor
import Validation

public struct Required: Validator {
    public typealias Input = Node?

    public func validate(_ input: Node?) throws {
        guard let input = input else {
            throw Abort(
                .badRequest,
                metadata: nil,
                reason: "The value is null."
            )
        }

        if let string = input.string {
            guard !string.isEmpty else {
                throw Abort(
                    .badRequest,
                    metadata: nil,
                    reason: "The value is an empty string."
                )
            }
        }

        if let array = input.array {
            guard array.count > 0 else {
                throw Abort(
                    .badRequest,
                    metadata: nil,
                    reason: "The value is an empty array."
                )
            }
        }
    }
}

extension Optional: Validatable {}
