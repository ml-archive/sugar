import Fluent
import Vapor

struct UniqueFieldValidationError: ValidationError {
    var path: [String]
    let reason: String

    init<U>(type: U.Type = U.self, value: CustomDebugStringConvertible) {
        reason =
            "An instance of type \"\(U.self)\" with value \(value.debugDescription) already exists."
        path = []
    }
}

public func validateThat<U: Model, T: Encodable & Equatable & CustomDebugStringConvertible>(
    only entity: U?,
    has value: T?,
    for keyPath: KeyPath<U, T>,
    on db: DatabaseConnectable
) -> Future<[ValidationError]> {
    guard let value = value else {
        return db.future([])
    }

    var query = U.query(on: db)
        .filter(keyPath == value)

    if let entity = entity {
        query = query.filter(U.idKey != entity[keyPath: U.idKey])
    }

    return query
        .count()
        .map { count in
            guard count == 0 else {
                return [UniqueFieldValidationError(type: U.self, value: value)]
            }
            return []
        }
}
