import Vapor

public extension CommandConfig {
    mutating func use(_ list: [String: Command]) {
        for item in list {
            self.use(item.value, as: item.key)
        }
    }
}
