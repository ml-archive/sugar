import Foundation
import JWT

public struct ExpireableJWTSigner {
    public let expirationPeriod: TimeInterval
    public let signer: JWTSigner

    public init(expirationPeriod: TimeInterval, signer: JWTSigner) {
        self.expirationPeriod = expirationPeriod
        self.signer = signer
    }
}
