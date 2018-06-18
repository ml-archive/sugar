import Leaf

public extension LeafTagConfig {
    public mutating func use(_ list: [String: TagRenderer]) {
        for item in list {
            self.use(item.value, as: item.key)
        }
    }
}
