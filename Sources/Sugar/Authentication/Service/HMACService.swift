//
//  SignerService.swift
//  Sugar
//
//  Created by Gustavo Perdomo on 6/9/18.
//

import Foundation
import Crypto
import JWT

public final class HMACService: SignerService {
    public let signer: ExpireableJWTSigner
    
    public init(secret: String, expirationPeriod: TimeInterval, algorithm: DigestAlgorithm = .sha256) throws {
        let signer: JWTSigner
        switch algorithm {
        case .sha256: signer = JWTSigner.hs256(key: Data(secret.utf8))
        case .sha384: signer = JWTSigner.hs384(key: Data(secret.utf8))
        case .sha512: signer = JWTSigner.hs512(key: Data(secret.utf8))
        default: throw SignerServiceError(identifier: "badHMACAlgorithm", reason: "HMAC signing requires SHA256, SHA384, or SHA512 algorithm", status: .internalServerError)
        }
        
        self.signer = ExpireableJWTSigner(expirationPeriod: expirationPeriod, signer: signer)
    }
}
