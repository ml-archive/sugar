import JWT
import Fluent

public protocol ExpireableSubjectPayload: JWTPayload {
    var exp: ExpirationClaim { get }
    var sub: SubjectClaim { get }
}

extension ExpireableSubjectPayload {
    func verify() throws {
        try exp.verify()
    }
}
