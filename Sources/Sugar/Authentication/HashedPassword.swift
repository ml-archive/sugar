import Crypto

/// Wrapper for password strings that can only be instantiated using hashed passwords of sufficient
/// strength.
public struct HashedPassword: Codable, Equatable {
    public let value: String
    fileprivate init(_ input: LosslessStringConvertible) {
        value = input.description
    }
}

public protocol HasHashedPassword {
    static var bCryptCost: Int { get }
    static func validateStrength(ofPassword password: String) throws
    var password: HashedPassword { get }
}

extension HasHashedPassword {

    /// Hashes password.
    ///
    /// - Parameter password: password to validate and hash
    /// - Returns: a HashedPassword value based on the input and `bCryptCost`
    /// - Throws: PasswordError.weakPassword when password is not strong enough
    public static func hashPassword(_ password: String) throws -> HashedPassword {
        try validateStrength(ofPassword: password)
        return try HashedPassword(BCrypt.hash(password, cost: bCryptCost))
    }

    /// Validates password strength.
    ///
    /// - Parameter password: password string to validate
    /// - Throws: PasswordError.weakPassword when password is not strong enough
    public static func validateStrength(ofPassword password: String) throws {
        // TODO: stricter validation
        guard password.count > 8 else {
            throw PasswordError.weakPassword
        }
    }

    /// Verifies whether provided password matches the hashed password.
    ///
    /// - Parameter password: password to verify
    /// - Returns: a boolean indicating whether passwords match
    public func verify(_ password: String) throws -> Bool {
        return try BCrypt.verify(password, created: self.password.value)
    }
}

public enum PasswordError: Error {
    case weakPassword
}

// MARK: - MySQLDataConvertible

import MySQL

extension HashedPassword: MySQLDataConvertible {
    public func convertToMySQLData() throws -> MySQLData {
        return MySQLData(string: value)
    }

    public static func convertFromMySQLData(_ mysqlData: MySQLData) throws -> HashedPassword {
        return try self.init(mysqlData.decode(String.self))
    }
}
