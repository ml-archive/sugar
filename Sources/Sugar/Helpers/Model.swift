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

    public func saveOrUpdate<T>(
        given values: [WritableKeyPath<Self, T>: T],
        on db: DatabaseConnectable
    ) throws -> Future<Self> {
        var query = Self.query(on: db)
        for (field, value) in values {
            query = try query.filter(field == value)
        }

        return query.first().flatMap(to: Self.self) { result in
            guard let result = result else {
                return self.save(on: db)
            }

            var copy = self
            copy.fluentID = result.fluentID

            return copy.save(on: db)
        }
    }
}
