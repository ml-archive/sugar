//
//  SignerService.swift
//  Sugar
//
//  Created by Gustavo Perdomo on 6/9/18.
//

import Debugging
import Vapor

public struct SignerServiceError: Debuggable, AbortError, Error {
    public let identifier: String
    public let reason: String
    public let status: HTTPResponseStatus
}

public protocol SignerService: Service {
    var signer: ExpireableJWTSigner { get }
}
