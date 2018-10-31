import JWT

/// A commonly used payload with a subject and expiration claim.
public struct Payload: ExpireableSubjectPayload {
    /// See `ExpireableSubjectPayload`
    public let exp: ExpirationClaim

    /// See `ExpireableSubjectPayload`
    public let sub: SubjectClaim

    /// Create a new `Payload`.
    ///
    /// - Parameters:
    ///   - exp: the expiration claim.
    ///   - sub: the subject claim containing information to identify a user.
    public init(
        exp: ExpirationClaim,
        sub: SubjectClaim
    ) {
        self.exp = exp
        self.sub = sub
    }

    /// See `JWTVerifiable`
    public func verify(using signer: JWTSigner) throws {
        try exp.verifyNotExpired()
    }
}
