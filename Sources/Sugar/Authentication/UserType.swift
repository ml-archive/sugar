import Authentication
import Crypto
import Fluent
import Vapor

public protocol UserType {
    associatedtype Login: HasReadablePassword
    associatedtype Registration: HasReadablePassword
    associatedtype Update: Decodable

    init(_: Registration) throws
    static func logIn(with: Login, on worker: DatabaseConnectable) -> Future<Self>
    func update(using: Update) throws
}

public protocol HasReadableUser {
    /// The username, sometimes an email address
    var username: String { get }
}

extension UserType where
    Self: PasswordAuthenticatable,
    Self.Database: QuerySupporting,
    Self.Login: HasReadableUser
{
    public static func logIn(with login: Login, on worker: DatabaseConnectable) -> Future<Self> {
        return Self
            .authenticate(
                username: login.username,
                password: login.password,
                using: BCrypt,
                on: worker
            )
            .unwrap(or: AuthenticationError.userNotFound)
    }
}

extension UserType where
    Self: PasswordAuthenticatable,
    Self.Database: QuerySupporting
{
    public static func logIn(on req: Request) throws -> Future<Self> {
        return try req
            .content
            .decode(Login.self)
            .flatMap(to: Self.self) { login in
                Self.logIn(with: login, on: req)
            }
    }

    public static func register(on req: Request) throws -> Future<Self> {
        return try req.content
            .decode(Registration.self)
            .flatMap(to: Self.self) { registration in
                return try Self(registration).save(on: req)
            }
    }
}
