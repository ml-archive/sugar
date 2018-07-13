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
