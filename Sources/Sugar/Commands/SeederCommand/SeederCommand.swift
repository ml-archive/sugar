import Vapor
import Fluent

public struct SeederCommand<M: Seedable>: Command {
    private let databaseIdentifier: DatabaseIdentifier<M.Database>

    public init(databaseIdentifier: DatabaseIdentifier<M.Database>) {
        self.databaseIdentifier = databaseIdentifier
    }

    public var arguments: [CommandArgument] {
        return M.arguments
    }

    public var options: [CommandOption] {
        return M.options
    }

    public var help: [String] {
        return [M.help]
    }

    public func run(using context: CommandContext) throws -> Future<Void> {
        return context.container.withNewConnection(to: databaseIdentifier) { db in
            let seedable = try M(command: context)
            return seedable.save(on: db).transform(to: ())
        }
    }
}
