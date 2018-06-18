import Leaf

public extension LeafTagConfig {
    public func use(_ list: [String: TagRenderer]) {
        for item in list {
            self.use(item.value, as: item.key)
        }
    }
}
