import Vapor

/// A value that can one of two types
public enum Either<L, R> {
    case left(L)
    case right(R)
}

extension Either: ResponseEncodable where L: ResponseEncodable, R: ResponseEncodable {
    /// See `ResponseEncodable.encode`
    public func encode(for req: Request) throws -> Future<Response> {
        switch self {
        case .left(let left): return try left.encode(for: req)
        case .right(let right): return try right.encode(for: req)
        }
    }
}

extension Future {
    /// Transforms a `Future` into one that can be either the value or an error of a given type.
    ///
    /// - Parameter type: The `Error` type to be promoted.
    /// - Returns: A `Future` that yields either a value or an error.
    public func promoteErrors<E: Error>(ofType type: E.Type = E.self) -> Future<Either<T, E>> {
        return map(Either.left)
            .catchMap {
                guard let error = $0 as? E else {
                    throw $0
                }
                return .right(error)
            }
    }
}

extension Either: Equatable where L: Equatable, R: Equatable {
    #if swift(>=4.2)
        // automatically synthesized in swift 4.2
    #else
    public static func == (lhs: Either<L, R>, rhs: Either<L, R>) -> Bool {
        switch (lhs, rhs) {
        case (.left(let lhs), .left(let rhs)) where lhs == rhs:
            return true
        case (.right(let lhs), .right(let rhs)) where lhs == rhs:
            return true
        default:
            return false
        }
    }
    #endif
}
