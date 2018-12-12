import Vapor

/// Types conforming to this protocol are to create instances from a `Request`.
public protocol RequestCreatable {

    /// Create an instance from a `Request`.
    ///
    /// - Parameter req: the request.
    /// - Returns: a `Future` of `Self`.
    static func create(on req: Request) throws -> Future<Self>
}

extension RequestCreatable where Self: Decodable {

    /// See `RequestCreatable`.
    public static func create(on req: Request) throws -> Future<Self> {
        return try req.content.decode(Self.self)
    }
}
