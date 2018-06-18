import JWT
import Fluent

/// A JWT Payload with an expiration time and authentication information
public protocol ExpireableSubjectPayload: JWTPayload {

    /// The payload's last valid time
    var exp: ExpirationClaim { get }

    /// Contains the information to authenticate
    var sub: SubjectClaim { get }
}

extension ExpireableSubjectPayload {

    /// See `JWTVerifiable.verify`
    func verify() throws {
        try exp.verify()
    }
}
