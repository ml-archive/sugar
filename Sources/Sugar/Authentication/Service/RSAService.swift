import Foundation
import Crypto
import JWT

public final class RSAService: SignerService {
    public let signer: ExpireableJWTSigner
    
    public init(key: RSAKey, expirationPeriod: TimeInterval, algorithm: DigestAlgorithm = .sha256) throws {
        let signer: JWTSigner
        switch algorithm {
        case .sha256: signer = .rs256(key: key)
        case .sha384: signer = .rs384(key: key)
        case .sha512: signer = .rs512(key: key)
        default: throw SignerServiceError(identifier: "badRSAAlgorithm", reason: "RSA signing requires SHA256, SHA384, or SHA512 algorithm", status: .internalServerError)
        }
        
        self.signer = ExpireableJWTSigner(expirationPeriod: expirationPeriod, signer: signer)
    }
    
    public convenience init(secret: String, type: RSAKeyType = .private, expirationPeriod: TimeInterval, algorithm: DigestAlgorithm = .sha256) throws {
        let key: RSAKey
        
        switch type {
        case .public: key = try .public(pem: secret)
        case .private: key = try .private(pem: secret)
        }
        
        try self.init(key: key, expirationPeriod: expirationPeriod, algorithm: algorithm)
    }
    
    public convenience init(n: String, e: String, d: String? = nil, expirationPeriod: TimeInterval, algorithm: DigestAlgorithm = .sha256) throws {
        let key = try RSAKey.components(n: n, e: e, d: d)
        
        try self.init(key: key, expirationPeriod: expirationPeriod, algorithm: algorithm)
    }
}

