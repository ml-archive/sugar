import Authentication
import Crypto
import Fluent
import Vapor

public protocol UserType {
    associatedtype Login: HasReadablePassword
    associatedtype Registration: HasReadablePassword
    associatedtype Update: Decodable
    associatedtype Public: Content

    init(_: Registration) throws
    func update(with: Update) throws

    static func logIn(with: Login, on worker: DatabaseConnectable) -> Future<Self>
    /// Performs work, such as validation, before the user is being created.
    ///
    /// - Parameters:
    ///   - registration: The registration object.
    ///   - worker: An object for connecting to the database.
    /// - Returns: A future without a value indicating that the user can be created.
    /// - Throws: If the user shouldn't be registered.
    static func preRegister(
        with registration: Registration,
        on worker: DatabaseConnectable
    ) throws -> Future<Void>

    /// Performs work, such as validation, before the user is being updated.
    ///
    /// - Parameters:
    ///   - registration: The update object.
    ///   - worker: An object for connecting to the database.
    /// - Returns: A future without a value indicating that the user can be updated.
    /// - Throws: If the user shouldn't be updated.
    func preUpdate(with registration: Update, on worker: DatabaseConnectable) throws -> Future<Void>
}

extension UserType {
    /// Default implementation that does nothing.
    public func preUpdate(
        with registration: Update,
        on worker: DatabaseConnectable
    ) throws -> Future<Void> {
        return .done(on: worker)
    }
}

extension UserType where
    Self: Model,
    Self: PasswordAuthenticatable,
    Self.Database: QuerySupporting,
    Self.Login: HasReadableUsername,
    Self.Registration: HasReadableUsername
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

extension UserType where
    Self: Model,
    Self: PasswordAuthenticatable,
    Self.Database: QuerySupporting,
    Self.Registration: HasReadableUsername
{
    public static func preRegister(
        with registration: Registration,
        on worker: DatabaseConnectable
    ) throws -> Future<Void> {
        return try Self.query(on: worker)
            .filter(Self.usernameKey == registration[keyPath: Registration.readableUsernameKey])
            .first()
            .nil(or: AuthenticationError.usernameAlreadyExists)
    }
}

extension UserType where
    Self: Model,
    Self: PasswordAuthenticatable,
    Self.Database: QuerySupporting,
    Self.Update: HasUpdatableUsername,
    Self.Update: HasUpdatablePassword,
    Self: HasPassword
{
    public func preUpdate(
        with update: Update,
        on worker: DatabaseConnectable
    ) throws -> Future<Void> {
        if
            update[keyPath: Update.updatablePasswordKey] != nil,
            update[keyPath: Update.updatableUsernameKey] == nil,
            update[keyPath: Update.oldPasswordKey] == nil
        {
            throw AuthenticationError.passwordWithoutUsernameOrOldPassword
        }

        if let oldPassword = update[keyPath: Update.oldPasswordKey] {
            guard try verify(oldPassword) else {
                throw AuthenticationError.incorrectOldPassword
            }
        }

        if let username = update[keyPath: Update.updatableUsernameKey] {
            guard
                let password = update[keyPath: Update.updatablePasswordKey],
                try verify(password)
            else {
                throw AuthenticationError.incorrectPassword
            }

            return try Self.query(on: worker)
                .filter(Self.usernameKey == username)
                .first()
                .try { user in
                    guard
                        user == nil || user?[keyPath: Self.idKey] == self[keyPath: Self.idKey]
                    else {
                        throw AuthenticationError.usernameAlreadyExists
                    }
                }
                .transform(to: ())
        }

        return .done(on: worker)
    }
}

extension UserType where
    Self: Model,
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
            .flatTry { registration in
                try Self.preRegister(with: registration, on: req)
            }
            .flatMap(to: Self.self) { registration in
                return try Self(registration).save(on: req)
            }
    }

    public static func update(on req: Request) throws -> Future<Self> {
        let user = try req.requireAuthenticated(Self.self)

        return try req
            .content
            .decode(Update.self)
            .flatTry { update in
                try user.preUpdate(with: update, on: req)
            }
            .flatMap { update in
                try user.update(with: update)
                return user.save(on: req)
            }
    }
}

extension JWTAuthenticatable where
    Self: Model,
    Self.Database: QuerySupporting,
    Self.ID: LosslessStringConvertible
{
    /// See `JWTAuthenticatable`.
    public static func authenticate(
        using payload: JWTPayload,
        on connection: DatabaseConnectable
    ) throws -> Future<Self?> {
        guard let id = ID(payload.sub.value) else {
            throw Sugar.AuthenticationError.malformedPayload
        }

        return try find(id, on: connection)
    }
}

