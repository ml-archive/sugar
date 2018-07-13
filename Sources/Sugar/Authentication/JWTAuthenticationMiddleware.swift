import Authentication
import JWT
import Vapor

/// A middleware that authenticates by extracting and verifying a JWT (JSON Web Token) from the
/// Authorization header. By default it will also load the user (or whatever authenticatable entity
/// is used) from the database but this can be disabled for performance reasons if it is not needed.
///
/// Authentication is skipped if authentication has already occurred, e.g. in a previous middleware.
public final class JWTAuthenticationMiddleware<A: JWTAuthenticatable>: Middleware {
    let shouldAuthenticate: Bool
    let signerKey: String

    /// Creates a new JWT Authentication Middleware
    ///
    /// - Parameters:
    ///   - key: the key of the signer you want to use
    ///   - shouldAuthenticate: whether full authentication (which usually includes a database
    ///     query) should be performed
    public init(using key: String, shouldAuthenticate: Bool = true) {
        self.signerKey = key
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
            throw AuthenticationError.missingToken
        }

        let jwt: JWT<A.JWTPayload>
        do {
            let signers = try req.make(SignersService.self)
            jwt = try JWT<A.JWTPayload>(from: bearer.token, verifiedUsing: signers.require(self.signerKey).signer)
        } catch let error as JWTError where error.identifier == "exp" {
            return try Future
                .transform(to: HTTPResponse.init(status: .unauthorized), on: req)
                .encode(for: req)
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
