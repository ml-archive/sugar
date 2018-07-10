import Foundation
import JWT

/// A convenient combination of an expiration period and a signer
public struct ExpireableJWTSigner {

    /// The amount of time added to 'now' when setting the expiration time for a JWT
    public let expirationPeriod: TimeInterval

    /// The signer used for signing JWTs
    public let signer: JWTSigner

    public init(expirationPeriod: TimeInterval, signer: JWTSigner) {
        self.expirationPeriod = expirationPeriod
        self.signer = signer
    }

    public func sign<Payload>(_ jwt: inout JWT<Payload>) throws -> Data {
        return try self.signer.sign(&jwt)
    }

    public func verify(_ signature: Data, header: Data, payload: Data) throws -> Bool {
        return try self.signer.verify(signature, header: header, payload: payload)
    }
}

public extension JWT {
    public init(from string: String, verifiedUsing signer: ExpireableJWTSigner) throws {
        try self.init(from: string, verifiedUsing: signer.signer)
    }
}
