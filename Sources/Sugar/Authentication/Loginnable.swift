import Authentication
import Vapor

public protocol Loginnable {
    associatedtype Login: HasReadablePassword

    static func preLogin(on req: Request) -> Future<Void>
    static func logIn(with login: Login, on worker: DatabaseConnectable) -> Future<Self>
}

extension Loginnable {
    public static func preLogin(on req: Request) -> Future<Void> {
        return req.future()
    }
}

extension Loginnable where
    Self: Model,
    Self: PasswordAuthenticatable,
    Self: Creatable,
    Self.Login: HasReadableUsername,
    Self.Create: HasReadableUsername
{
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

extension Loginnable where
    Self: Model,
    Self: PasswordAuthenticatable,
    Self.Login: Decodable
{
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
