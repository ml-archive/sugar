import Node

extension Node {
    /// Initializer with `Node.null` fallback if value is not present.
    ///
    /// - Parameter value: value to wrap with Node.
    public init(optional value: Bool?) {
        guard let value = value else {
            self = .null
            return
        }
        self = .bool(value)
    }

    /// Initializer with `Node.null` fallback if value is not present.
    ///
    /// - Parameter value: value to wrap with Node.
    public init(optional value: String?) {
        guard let value = value else {
            self = .null
            return
        }
        self = .string(value)
    }

    /// Initializer with `Node.null` fallback if value is not present.
    ///
    /// - Parameter value: value to wrap with Node.
    public init(optional value: Int?) {
        guard let value = value else {
            self = .null
            return
        }
        self = .number(Number(value))
    }

    /// Initializer with `Node.null` fallback if value is not present.
    ///
    /// - Parameter value: value to wrap with Node.
    public init(optional value: Double?) {
        guard let value = value else {
            self = .null
            return
        }
        self = .number(Number(value))
    }

    /// Initializer with `Node.null` fallback if value is not present.
    ///
    /// - Parameter value: value to wrap with Node.
    public init(optional value: UInt?) {
        guard let value = value else {
            self = .null
            return
        }
        self = .number(Number(value))
    }
}
