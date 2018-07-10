import Vapor

public final class SignersService: Service {
    private var storage: [String: ExpireableJWTSigner]
    
    /// Create a new collection of `ExpireableJWTSigner`
    public init(signers: [String: ExpireableJWTSigner]) {
        self.storage = signers
    }
    
    /// Create a new empty collection of `ExpireableJWTSigner`
    public init() {
        self.storage = [:]
    }
    
    /// Gets an instance of `ExpireableJWTSigner` parsed from the value associated with the `key`
    ///
    /// - Parameter key: key to retrieve
    /// - Returns: A optional `ExpireableJWTSigner`
    public func get(_ key: String) -> ExpireableJWTSigner? {
        return storage[key]
    }
    
    /// Sets the value to an `ExpireableJWTSigner` at the supplied `key`.
    ///
    /// - Parameters:
    ///   - key: key to set
    ///   - signer: An `ExpireableJWTSigner` item to set.
    public func set(_ key: String, signer: ExpireableJWTSigner) {
        storage[key] = signer
    }
    
    /// Removes the value associated with the `key`.
    ///
    /// - Parameter key: key to remove
    public func remove(_ key: String) {
        storage[key] = nil
    }
    
    
    /// Gets an instance of `ExpireableJWTSigner` parsed from the value associated with the `key`
    ///
    /// - Parameter key: key to retrieve
    /// - Returns: A `ExpireableJWTSigner`
    /// - Throws: SignerServiceError if key not exists
    public func require(_ key: String) throws -> ExpireableJWTSigner {
        guard let signer = self.get(key) else {
            throw SignerServiceError(identifier: "unknownKID", reason: "No \(ExpireableJWTSigner.self) are available for the supplied `key`", status: .internalServerError)
        }
        return signer
    }
}
