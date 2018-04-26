import Vapor

/// Errors that can be thrown during authentication
public enum AuthenticationError: String, Error {
    case bearerAuthorizationHeaderRequired
    case signingError
    case userNotFound
    case weakPassword
}

// MARK: - AbortError
extension AuthenticationError: AbortError {

    /// See `AbortError.status`
    public var status: HTTPResponseStatus {
        switch self {
        case .bearerAuthorizationHeaderRequired : return .unauthorized
        case .signingError                      : return .internalServerError
        case .userNotFound                      : return .unauthorized
        case .weakPassword                      : return .unprocessableEntity
        }
    }

    /// See `AbortError.reason`
    public var reason: String {
        switch self {
        case .bearerAuthorizationHeaderRequired:
            return "Bearer Authorization Header Required"
        case .signingError:
            return "Could not convert signed JWT into String"
        case .userNotFound:
            return "Could not find user"
        case .weakPassword:
            return "The supplied password did not meet the password strength requirements"
        }
    }
}

// MARK: - Debuggable
extension AuthenticationError: Debuggable {

    /// See `Debuggable.identifier`
    public var identifier: String {
        return rawValue
    }
}
