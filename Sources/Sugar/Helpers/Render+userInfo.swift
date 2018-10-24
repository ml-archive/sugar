import Vapor

extension ViewRenderer {

    /// Renders the template bytes into a view using the supplied `Encodable` object as context and
    /// makes the `Request` available to the tags by including it in the `userInfo` value.
    ///
    /// - Parameters:
    ///     - path: Path to file contianing raw template bytes.
    ///     - context: `Encodable` item that will be encoded to `TemplateData` and used as template
    ///         context.
    ///     - userInfo: User-defined storage.
    ///     - req: Request
    /// - Returns: `Future` containing the rendered `View`.
    public func render<E>(
        _ path: String,
        _ context: E,
        userInfo: [AnyHashable: Any] = [:],
        on req: Request
    ) -> Future<View> where E: Encodable {
        var userInfo = userInfo
        userInfo[requestUserInfoKey] = req
        return render(path, context, userInfo: userInfo)
    }

    /// Renders the template bytes into a view using the supplied `Encodable` object as context and
    /// makes the `Request` available to the tags by including it in the `userInfo` value.
    ///
    /// - Parameters:
    ///     - path: Path to file contianing raw template bytes.
    ///     - userInfo: User-defined storage.
    ///     - req: Request
    /// - Returns: `Future` containing the rendered `View`.
    public func render(
        _ path: String,
        userInfo: [AnyHashable: Any] = [:],
        on req: Request
    ) -> Future<View> {
        return render(path, Dictionary<String, String>(), userInfo: userInfo, on: req)
    }
}

extension TagContext {

    /// Provides access to the `Request` stored in the `userInfo` dictionary.
    public var request: Request? {
        get {
            return context.userInfo[requestUserInfoKey] as? Request
        }
        set {
            context.userInfo[requestUserInfoKey] = newValue
        }
    }

    /// Returns the `Request` stored in the `userInfo` dictionary or throws an error.
    ///
    /// - Returns: the stored `Request`.
    /// - Throws: TagContextError.requestNotPassedIntoRender.
    public func requireRequest() throws -> Request {
        guard let request = request else {
            throw TagContextError.requestNotPassedIntoRender
        }
        return request
    }
}

private let requestUserInfoKey = "_sugar:request"

// MARK: - Error

enum TagContextError: Error {
    case requestNotPassedIntoRender
}

extension TagContextError: AbortError {
    var identifier: String {
        switch self {
        case .requestNotPassedIntoRender: return "requestNotPassedInToRender"
        }
    }

    var reason: String {
        switch self {
        case .requestNotPassedIntoRender: return "Request not passed into render call."
        }
    }

    var status: HTTPResponseStatus {
        return .internalServerError
    }
}
