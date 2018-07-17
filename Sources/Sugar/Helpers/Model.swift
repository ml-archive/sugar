import Fluent
import Vapor

public extension Model {
    public static func requireFind(
        _ id: ID,
        on worker: DatabaseConnectable
    ) -> Future<Self> {
        return Self
            .find(id, on: worker)
            .unwrap(or: Abort(.notFound, reason: "\(Self.self) with id \(id) not found"))
    }

    public func saveOrUpdate (
        given filters: [FilterOperator<Self.Database, Self>],
        withSoftDeleted: Bool = false,
        restore: Bool = false,
        on db: DatabaseConnectable
    ) throws -> Future<Self> {
        var query = Self.query(on: db, withSoftDeleted: withSoftDeleted)

        for filter in filters {
            query = query.filter(filter)
        }

        return query.first().flatMap(to: Self.self) { result in
            guard let result = result else {
                return self.save(on: db)
            }

            var copy = self
            copy.fluentID = result.fluentID
            copy.fluentCreatedAt = result.fluentCreatedAt
            copy.fluentDeletedAt = result.fluentDeletedAt

            let future = copy.update(on: db)

            guard restore else {
                return future
            }

            return future.flatMap { $0.restore(on: db) }
        }
    }
}

extension Model where Database: SchemaSupporting {
    public static func addProperties(
        to builder: SchemaCreator<Self>,
        excluding excludedProperties: [ReflectedProperty?]
    ) throws {
        guard let idProperty = try Self.reflectProperty(forKey: idKey) else {
            throw FluentError(identifier: "idProperty", reason: "Unable to reflect ID property for `\(Self.self)`.")
        }

        let properties = try Self.reflectProperties(depth: 0).filter { property in
            !excludedProperties.contains { excludedProperty in
                property.path == excludedProperty?.path
            }
        }

        for property in properties {
            let field = Database.schemaField(
                for: property.type,
                isIdentifier: idProperty.path == property.path,
                Database.queryField(.reflected(property, rootType: self))
            )
            Database.schemaFieldCreate(field, to: &builder.schema)
        }
    }

    public static func addProperties<T: Any>(
        to builder: SchemaCreator<Self>,
        excluding excludedKeyPaths: [KeyPath<Self, T>]
    ) throws {
        let excludedProperties = excludedKeyPaths
            .compactMap { try? Self.reflectProperty(forKey: $0) }

        try addProperties(to: builder, excluding: excludedProperties)
    }
}
