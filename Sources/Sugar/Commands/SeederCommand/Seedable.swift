import Vapor
import Fluent

public protocol Seedable: Model {
    static var arguments: [CommandArgument] { get }
    static var options: [CommandOption] { get }
    static var help: String { get }

    init(command: CommandContext) throws
}

public extension Seedable {
    static var arguments: [CommandArgument] {
        return []
    }

    static var options: [CommandOption] {
        return []
    }
}
