import Authentication
import Vapor

/// Expresses the ability for a type (e.g. a user type) to be logged in.
public protocol Loginable {

    /// Payload containing the information required to perform a login.
    associatedtype Login

    /// Used to perform any pre-login steps such as validation.
    ///
    /// - Parameter req: the request.
    /// - Returns: a `Future<Void>` signaling success or failure.
    static func preLogin(on req: Request) -> Future<Void>

    /// Performs the actual login. Called after `preLogin(on:)`.
    ///
    /// - Parameters:
    ///   - login: the login information.
    ///   - worker: a worker on which to perform any database related actions like user lookup.
    /// - Returns: an instance of self in the `Future` on successful login.
    static func logIn(with login: Login, on worker: DatabaseConnectable) -> Future<Self>
}

extension Loginable {

    /// Default implementation that does nothing.
    /// See `Loginable`.
    public static func preLogin(on req: Request) -> Future<Void> {
        return req.future()
    }
}

extension Loginable where
    Self: PasswordAuthenticatable,
    Self.Login: HasReadableUsername,
    Self.Login: HasReadablePassword
{
    /// Default implementation that uses functionality provided by `PasswordAuthenticatable`.
    /// See `Loginable`.
    public static func logIn(with login: Login, on worker: DatabaseConnectable) -> Future<Self> {
        return Self
            .authenticate(
                username: login[keyPath: Login.readableUsernameKey],
                password: login[keyPath: Login.readablePasswordKey],
                using: BCrypt,
                on: worker
            )
            .unwrap(or: AuthenticationError.userNotFound)
    }
}

extension Loginable where Self.Login: Decodable {

    /// Convenience function that combines `preLogin` and `logIn`.
    ///
    /// - Parameter req: the request.
    /// - Returns: an instance of self in the `Future` on successful login.
    public static func logIn(on req: Request) -> Future<Self> {
        return preLogin(on: req)
            .flatMap {
                try req.content.decode(Login.self)
            }
            .flatMap(to: Self.self) { login in
                Self.logIn(with: login, on: req)
            }
    }
}
