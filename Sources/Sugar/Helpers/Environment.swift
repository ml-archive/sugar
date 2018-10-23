import Vapor

public extension Environment {
    enum EnvironmentError: Error {
        case keyNotFound(key: String)
    }

    public static func get(_ key: String, _ fallback: String) -> String {
        return ProcessInfo.processInfo.environment[key] ?? fallback
    }

    public static func get(_ key: String) -> String? {
        return ProcessInfo.processInfo.environment[key]
    }

    public static func assertGet(_ key: String) throws -> String {
        guard let value = Environment.get(key) else {
            throw Environment.EnvironmentError.keyNotFound(key: key)
        }
        return value
    }
}

public func env(_ key: String, _ fallback: String) -> String {
    return Environment.get(key, fallback)
}

public func env(_ key: String) -> String? {
    return Environment.get(key)
}

public func assertEnv(_ key: String) throws -> String {
    return try Environment.assertGet(key)
}
