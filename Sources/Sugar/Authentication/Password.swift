import Crypto

/// Types conforming to this protocol can create, validate, and verify passwords
public protocol HasPassword {
    /// Complexity for hashing algorithm
    static var bCryptCost: Int { get }

    static func validateStrength(ofPassword password: String) throws

    var password: String { get set }
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
    public static func hashPassword(_ password: String) throws -> String {
        try validateStrength(ofPassword: password)
        return try BCrypt.hash(password, cost: bCryptCost)
    }

    /// Verifies whether provided password matches the hashed password.
    ///
    /// - Parameter password: password to verify
    /// - Returns: a boolean indicating whether passwords match
    public func verify(_ password: String) throws -> Bool {
        return try BCrypt.verify(password, created: self.password)
    }
}

/// Types conforming to this protocol can be used for login or register requests
public protocol HasReadablePassword: Decodable {
    var password: String { get }
}
