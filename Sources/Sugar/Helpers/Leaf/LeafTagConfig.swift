import Leaf

public extension LeafTagConfig {
    /// Register multiple tags using the keys as their names.
    ///
    /// - Parameter list: Map of names to tags.
    public mutating func use(_ list: [String: TagRenderer]) {
        for item in list {
            self.use(item.value, as: item.key)
        }
    }
}
