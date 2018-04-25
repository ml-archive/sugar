import Vapor

public enum AuthenticationError: String, Error {
    case bearerAuthorizationHeaderRequired
    case signingError
    case weakPassword
}

// MARK: - AbortError
extension AuthenticationError: AbortError {
    public var status: HTTPResponseStatus {
        switch self {
        case .bearerAuthorizationHeaderRequired : return .unauthorized
        case .signingError                      : return .internalServerError
        case .weakPassword                      : return .unprocessableEntity
        }
    }

    public var reason: String {
        switch self {
        case .bearerAuthorizationHeaderRequired:
            return "Bearer Authorization Header Required"
        case .signingError:
            return "Could not convert signed JWT into String"
        case .weakPassword:
            return "The supplied password did not meet the password strength requirements"
        }
    }
}

// MARK: - Debuggable
extension AuthenticationError: Debuggable {
    public var identifier: String {
        return rawValue
    }
}
