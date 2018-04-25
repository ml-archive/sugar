import JWT

public struct Payload: ExpireableSubjectPayload {
    public let exp: ExpirationClaim
    public let sub: SubjectClaim

    public init(
        exp: ExpirationClaim,
        sub: SubjectClaim
    ) {
        self.exp = exp
        self.sub = sub
    }

    public func verify() throws {
        try exp.verify()
    }
}
