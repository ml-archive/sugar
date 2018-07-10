import Foundation
import Crypto
import JWT

public final class CertService: SignerService {
    public var signer: ExpireableJWTSigner
    
    public init(certificate: String, expirationPeriod: TimeInterval, algorithm: DigestAlgorithm = .sha256) throws {
        let key = try RSAKey.public(certificate: certificate)
        let signer: JWTSigner
        
        switch algorithm {
        case .sha256: signer = .rs256(key: key)
        case .sha384: signer = .rs384(key: key)
        case .sha512: signer = .rs512(key: key)
        default: throw SignerServiceError(identifier: "badRSAAlgorithm", reason: "RSA signing requires SHA256, SHA384, or SHA512 algorithm", status: .internalServerError)
        }
        
        self.signer = ExpireableJWTSigner(expirationPeriod: expirationPeriod, signer: signer)
    }
}
