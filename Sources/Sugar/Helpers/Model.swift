import Fluent
import Vapor

public extension Model where Database: QuerySupporting {
    public static func requireFind(
        _ id: ID,
        on worker: DatabaseConnectable
    ) throws -> Future<Self> {
        return try Self
            .find(id, on: worker)
            .unwrap(or: Abort(.notFound, reason: "\(Self.self) with id \(id) not found"))
    }
}
