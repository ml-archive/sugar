import HTTP
import Vapor
import AuthProvider

public final class SimpleAuthMiddleware: Middleware {
    private let token: String
    private let authSource: (Request) -> String?
    private let shouldAuth: (Request) -> Bool
    private let error: AbortError

    public init(
        token: String,
        authSource: @escaping (Request) -> String? = { $0.auth.header?.string },
        shouldAuth: @escaping (Request) -> Bool = { _ in true },
        error: AbortError = Abort.unauthorized
    ) {
        self.token = token
        self.authSource = authSource
        self.shouldAuth = shouldAuth
        self.error = error
    }

    public func respond(to request: Request, chainingTo next: Responder) throws -> Response {
        // Make sure we should auth
        guard shouldAuth(request) else {
            return try next.respond(to: request)
        }

        // Check for token
        guard let authSource = authSource(request), authSource == token else {
            throw error
        }

        return try next.respond(to: request)
    }
}
