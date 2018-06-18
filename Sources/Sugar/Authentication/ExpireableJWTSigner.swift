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
}
