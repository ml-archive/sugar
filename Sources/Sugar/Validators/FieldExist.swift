import Fluent
import Validation

public struct Exists<T>: Validator where T: Entity {
    public typealias Input = Node

    internal let column: String
    internal let filters: ((Query<T>) throws -> Void)?

    public init(column: String = "id", filters: ((Query<T>) throws -> Void)? = nil) {
        self.column = column
        self.filters = filters
    }

    public func validate(_ input: Node) throws {
        do {
            let query = try T.makeQuery().filter(column, input)
            try filters?(query)

            guard try query.first() != nil else {
                throw error("Entity does not exist")
            }
        } catch _ {
            throw error("Entity does not exist")
        }
    }
}


extension Node : Validatable {}
