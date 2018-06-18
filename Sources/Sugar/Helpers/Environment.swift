import Vapor

public extension Environment {
    public static func get(_ key: String, _ fallback: String) -> String {
        return ProcessInfo.processInfo.environment[key] ?? fallback
    }
}

public func env(_ key: String, _ fallback: String) -> String {
    return Environment.get(key, fallback)
}
