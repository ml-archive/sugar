import Authentication
import JWT
import Vapor

/// Types confornming to this protocol will be able to be authenticated through an associated
/// JWT payload.
public protocol JWTAuthenticatable: Authenticatable {
    associatedtype JWTPayload: ExpireableSubjectPayload

    /// Authenticates using the supplied payload and connection.
    ///
    /// - Parameters:
    ///   - payload: a payload containing user identifiable information
    ///   - connection: the connection which which to load the user
    /// - Returns: the authenticated user or nil, in the future.
    static func authenticate(
        using payload: JWTPayload,
        on connection: DatabaseConnectable
    ) throws -> Future<Self?>

    /// Makes JWT Payload that is able to identify the user during authentication.
    ///
    /// - Parameters:
    ///   - expirationTime: time until which the JWT containing this payload is valid
    ///   - container: a container that can be used to access services
    /// - Returns: JWT Payload that is able to identify the user
    func makePayload(
        expirationTime: Date,
        on container: Container
    ) throws -> Future<JWTPayload>
}

extension JWTAuthenticatable {
    /// Create a signed token by making a payload and a JWT and signing it with the provided signer.
    ///
    /// - Parameters:
    ///   - signer:
    ///   - currentTime: the time that is used to determine the expiration time
    ///   - container: a container that is used as the worker for the event loop
    /// - Returns: a future signed token as a string
    public func signToken(
        using signer: ExpireableJWTSigner,
        currentTime: Date = .init(),
        on container: Container
    ) throws -> Future<String> {
        return try makePayload(expirationTime: currentTime + signer.expirationPeriod, on: container)
            .map(to: String?.self) {
                let jwt = JWT(payload: $0)
                return try String(bytes: jwt.sign(using: signer.signer), encoding: .utf8)
            }.unwrap(or: AuthenticationError.signingError)
    }
}
