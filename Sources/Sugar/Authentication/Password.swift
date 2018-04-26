import Crypto

/// Wrapper for password strings that can only be instantiated using hashed passwords of sufficient
/// strength.
public struct Password: Codable, Equatable {
    public fileprivate(set) var value: String
    fileprivate init(_ input: LosslessStringConvertible) {
        value = input.description
    }
}

/// Types conforming to this protocol can create, validate, and verify passwords
public protocol HasPassword {
    /// Complexity for hashing algorithm
    static var bCryptCost: Int { get }

    static func validateStrength(ofPassword password: String) throws

    var password: Password { get set }
}

// MARK: - Overrideable default implementations.
extension HasPassword {

    /// Default complexity for hashing algorithm. Higher values are more secure but significantly
    /// increase the hashing time. Consider overriding and using a lower value for development.
    public static var bCryptCost: Int {
        return 10
    }

    /// Default implementation for validating password strength.
    ///
    /// - Parameter password: password string to validate
    /// - Throws: PasswordError.weakPassword when password is not strong enough
    public static func validateStrength(ofPassword password: String) throws {
        // TODO: stricter validation
        guard password.count > 8 else {
            throw AuthenticationError.weakPassword
        }
    }
}

extension HasPassword {

    /// Hashes password.
    ///
    /// - Parameter password: password to validate and hash
    /// - Returns: a HashedPassword value based on the input and `bCryptCost`
    /// - Throws: PasswordError.weakPassword when password is not strong enough
    public static func hashPassword(_ password: String) throws -> Password {
        try validateStrength(ofPassword: password)
        return try Password(BCrypt.hash(password, cost: bCryptCost))
    }

    /// Verifies whether provided password matches the hashed password.
    ///
    /// - Parameter password: password to verify
    /// - Returns: a boolean indicating whether passwords match
    public func verify(_ password: String) throws -> Bool {
        return try BCrypt.verify(password, created: self.password.value)
    }
}

/// Types conforming to this protocol can be used for login or register requests
public protocol HasPasswordString: Decodable {
    var password: String { get }
}

// MARK: - MySQLDataConvertible

import FluentMySQL

extension Password: MySQLDataConvertible {

    /// See `MySQLDataConvertible.convertToMySQLData`
    public func convertToMySQLData() throws -> MySQLData {
        return MySQLData(string: value)
    }

    /// See `MySQLDataConvertible.convertFromMySQLData`
    public static func convertFromMySQLData(_ mysqlData: MySQLData) throws -> Password {
        return try self.init(mysqlData.decode(String.self))
    }
}

// MARK: - MySQLColumnDefinitionStaticRepresentable
extension Password: MySQLColumnDefinitionStaticRepresentable {

    /// See `MySQLColumnDefinitionStaticRepresentable.mySQLColumnDefinition`
    public static var mySQLColumnDefinition: MySQLColumnDefinition {
        return .varChar(length: 255)
    }
}
