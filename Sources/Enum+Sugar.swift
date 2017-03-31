import Node
import Vapor

/// Enables an enumeration to be convertable to-and-from a Node implicitly,
/// without having to use `Enum.case.rawValue`.
///
/// Example:
/// ```
///     enum State: String, RawStringConvertible {
///         case pending
///         case accepted
///     }
///
///     let state: State = .pending
///
///     node["state"] = state
///
///     let stateFromNode: State = try node.extract("state")
///
/// ```
protocol RawStringConvertible: NodeConvertible {
    init?(rawValue: String)
    var rawValue: String { get }
}

extension RawStringConvertible  {
    public init(node: Node) throws {
        guard let string = node.string else {
            throw Abort.custom(status: .internalServerError, message: "Expected a String")
        }
        
        guard let state = Self.init(rawValue: string) else {
            throw Abort.custom(status: .internalServerError, message: "Invalid case: \(string)")
        }
        
        self = state
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        return .string(self.rawValue)
    }
}
