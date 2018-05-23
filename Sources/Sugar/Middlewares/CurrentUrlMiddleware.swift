import Vapor

public final class CurrentURLProvider: Provider {
    public init() {}

    public func register(_ services: inout Services) throws {
        services.register { container in
            return CurrentUrlContainer()
        }
    }

    public func didBoot(_ container: Container) throws -> EventLoopFuture<Void> {
        return .done(on: container)
    }
}

public final class CurrentUrlContainer: Codable, Service {
    public var path: String = ""
}

public struct CurrentUrlMiddleware: Middleware {
    public init() {}

    /// See Middleware.respond
    public func respond(to req: Request, chainingTo next: Responder) throws -> Future<Response> {
        let container = try req.privateContainer.make(CurrentUrlContainer.self)
        container.path = req.http.urlString
        return try next.respond(to: req)
    }
}
