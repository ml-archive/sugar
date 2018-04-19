import Vapor
import Fluent

public protocol Seedable: Model where Database: QuerySupporting {
    static var arguments: [CommandArgument] { get }
    static var options: [CommandOption] { get }
    static var help: String { get }

    init(command: CommandContext) throws
}

public extension Seedable {
    public static var arguments: [CommandArgument] {
        return []
    }

    public static var options: [CommandOption] {
        return []
    }
}
