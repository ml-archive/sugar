import Vapor

extension Model {
    /// Attemps to unwrap the model's id and return it as an Int.
    public func idOrThrow() throws -> Int {
        guard let id = self.id?.int else {
            throw Abort.custom(
                status: .badRequest,
                message: "Missing id for \(type(of: self))"
            )
        }
        return id
    }
}

