import Authentication
import Vapor

public final class CurrentUserProvider<U: Authenticatable>: Provider {
    public init() {}

    public func register(_ services: inout Services) throws {
        services.register { container in
            return CurrentUserContainer<U>()
        }
    }

    public func didBoot(_ container: Container) throws -> EventLoopFuture<Void> {
        return .done(on: container)
    }
}

public final class CurrentUserContainer<U: Authenticatable>: Service {
    public var user: U?
}

public struct CurrentUserMiddleware<U: Authenticatable>: Middleware {
    public init() {}

    /// See Middleware.respond
    public func respond(to req: Request, chainingTo next: Responder) throws -> Future<Response> {
        let container = try req.privateContainer.make(CurrentUserContainer<U>.self)
        container.user = try req.authenticated()
        return try next.respond(to: req)
    }
}
