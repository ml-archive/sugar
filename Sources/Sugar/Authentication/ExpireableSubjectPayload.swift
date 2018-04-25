import JWT
import Fluent

public protocol ExpireableSubjectPayload: JWTPayload {
    var exp: ExpirationClaim { get }
    var sub: SubjectClaim { get }
    var verifiables: [JWTVerifiable] { get }
}

extension ExpireableSubjectPayload {
    public var verifiables: [JWTVerifiable] {
        return [exp]
    }

    func verify() throws {
        try verifiables.forEach { try $0.verify() }
    }
}
