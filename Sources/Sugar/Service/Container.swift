import Vapor

extension Container {
    public func baseURLString(includePort: Bool = true) throws -> String {
        let config = try make(NIOServerConfig.self)
        return "http://\(config.hostname)" + (includePort ? ":\(config.port)" : "")
    }
}
