import Vapor

extension Container {
    public func baseURLString(includePort: Bool = true) throws -> String {
        let config = try make(EngineServerConfig.self)
        return "http://\(config.hostname)" + (includePort ? ":\(config.port)" : "")
    }
}
