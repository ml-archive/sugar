import Vapor
import FluentProvider

extension Model {
    /// Attemps to unwrap the model's id and return it as an Int.
    public func idOrThrow() throws -> Int {
        guard let id = self.id?.int else {
            throw Abort(
                .badRequest,
                metadata: nil,
                reason: "Missing id for \(type(of: self))"
            )
        }
        return id
    }
}

