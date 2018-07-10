//
//  SignerService.swift
//  Sugar
//
//  Created by Gustavo Perdomo on 6/9/18.
//

import Foundation
import Crypto
import JWT

public final class RSAService: SignerService {
    public let signer: ExpireableJWTSigner
    
    public init(secret: String, type: RSAKeyType = .private, expirationPeriod: TimeInterval, algorithm: DigestAlgorithm = .sha256) throws {
        let signer: JWTSigner
        let key: RSAKey
        
        switch type {
        case .public: key = try RSAKey.public(pem: secret)
        case .private: key = try RSAKey.private(pem: secret)
        }
        
        switch algorithm {
        case .sha256: signer = JWTSigner.rs256(key: key)
        case .sha384: signer = JWTSigner.rs384(key: key)
        case .sha512: signer = JWTSigner.rs512(key: key)
        default: throw SignerServiceError(identifier: "badRSAAlgorithm", reason: "RSA signing requires SHA256, SHA384, or SHA512 algorithm", status: .internalServerError)
        }
        
        self.signer = ExpireableJWTSigner(expirationPeriod: expirationPeriod, signer: signer)
    }
    
    public init(n: String, e: String, d: String? = nil, expirationPeriod: TimeInterval, algorithm: DigestAlgorithm = .sha256)throws {
        let key = try RSAKey.components(n: n, e: e, d: d)
        let signer: JWTSigner
        
        switch algorithm {
        case .sha256: signer = JWTSigner.rs256(key: key)
        case .sha384: signer = JWTSigner.rs384(key: key)
        case .sha512: signer = JWTSigner.rs512(key: key)
        default: throw SignerServiceError(identifier: "badRSAAlgorithm", reason: "RSA signing requires SHA256, SHA384, or SHA512 algorithm", status: .internalServerError)
        }
        
        self.signer = ExpireableJWTSigner(expirationPeriod: expirationPeriod, signer: signer)
    }
}

