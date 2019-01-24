import HTTP
import Vapor
import AuthProvider

public final class SimpleAuthMiddleware: Middleware {
    private let token: String
    private let shouldAuth: (Request) -> Bool

    public init(token: String, shouldAuth: @escaping (Request) -> Bool = { _ in true }) {
        self.token = token
        self.shouldAuth = shouldAuth
    }

    public func respond(to request: Request, chainingTo next: Responder) throws -> Response {
        // Make sure we should auth
        guard shouldAuth(request) else {
            return try next.respond(to: request)
        }

        // Check for token
        guard let header = request.auth.header, header.string == token else {
            throw Abort.unauthorized
        }

        return try next.respond(to: request)
    }
}
