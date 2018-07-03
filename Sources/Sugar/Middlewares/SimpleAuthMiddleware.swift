import HTTP
import Vapor
import AuthProvider

internal final class SimpleAuthMiddleware: Middleware {
    private let token: String

    internal init(token: String) {
        self.token = token
    }

    func respond(to request: Request, chainingTo next: Responder) throws -> Response {
        let resp = try next.respond(to: request)

        guard
            let header = request.auth.header,
            header.string == token
        else {
            throw Abort.unauthorized
        }

        return resp
    }
}
