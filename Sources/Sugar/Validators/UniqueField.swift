import Fluent
import Validation

public struct UniqueField<T>: Validator where T: Entity {
    public typealias Input = Node

    internal let columns: [String]
    internal let filters: ((Query<T>) throws -> Void)?

    public init(column: String, filters: ((Query<T>) throws -> Void)? = nil) {
        self.init(columns: [column], filters: filters)
    }

    public init(columns: [String], filters: ((Query<T>) throws -> Void)? = nil) {
        self.columns = columns
        self.filters = filters
    }

    public func validate(_ input: NodeRepresentable) throws {
        let node = try input.makeNode(in: nil)

        if let inputs = node.array {
            try validate(inputs)
        } else {
            try validate([node])
        }
    }

    // required for `Validator` protocol to work.
    public func validate(_ input: Node) throws {
        try validate([input])
    }

    public func validate(_ inputs: [Node]) throws {
        do {
            guard inputs.count == columns.count else {
                throw error("Expected input for columns \(columns), got only \(inputs.count) inputs")
            }

            let query = try T.makeQuery()

            for (column, input) in zip(columns, inputs) {
                try query.filter(column, input)
            }

            try filters?(query)

            guard try query.first() == nil else {
                throw error("\(columns) must be unique")
            }
        } catch _ {
            throw error("\(columns) must be unique")
        }
    }
}
