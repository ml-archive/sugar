import Authentication
import JWT
import Vapor

/// A middleware that authenticates by extracting and verifying a JWT (JSON Web Token) from the
/// Authorization header. By default it will also load the user (or whatever authenticatable entity
/// is used) from the database but this can be disabled for performance reasons if it is not needed.
///
/// Authentication is skipped if authentication has already occurred, e.g. in a previous middleware.
public final class JWTAuthenticationMiddleware<A: JWTAuthenticatable>: Middleware {
    let signer: JWTSigner
    let shouldAuthenticate: Bool

    /// Creates a new JWT Authentication Middleware
    ///
    /// - Parameters:
    ///   - signer: the signer which with to verify the JWTs
    ///   - shouldAuthenticate: whether full authentication (which usually includes a database
    ///     query) should be performed
    public init(signer: JWTSigner, shouldAuthenticate: Bool = true) {
        self.signer = signer
        self.shouldAuthenticate = shouldAuthenticate
    }

    /// See `Middleware.respond`
    public func respond(
        to req: Request,
        chainingTo next: Responder
    ) throws -> Future<Response> {

        // return early if authentication has already occurred
        if try req.isAuthenticated(A.self) {
            return try next.respond(to: req)
        }

        guard let bearer = req.http.headers.bearerAuthorization else {
            return try next.respond(to: req)
        }

        let jwt: JWT<A.JWTPayload>
        do {
            jwt = try JWT<A.JWTPayload>(from: bearer.token, verifiedUsing: signer)
        } catch let error as JWTError where error.identifier == "exp" {
            return try req.future(HTTPResponse(status: .unauthorized)).encode(for: req)
        }

        guard shouldAuthenticate else {
            // we've verified the JWT and authentication is not requested so we're done
            return try next.respond(to: req)
        }

        return try A
            .authenticate(using: jwt.payload, on: req)
            .unwrap(or: AuthenticationError.userNotFound)
            .flatMap(to: Response.self) { object in
                // store the authenticated object on the request
                try req.authenticate(object)
                return try next.respond(to: req)
        }
    }
}
