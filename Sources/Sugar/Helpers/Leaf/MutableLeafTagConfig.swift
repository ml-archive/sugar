import Leaf
import Vapor

/// Service that can be used to add tags from multiple sources which can then be registered at once
/// on `Leaf`s `LeafTagConfig`.
/// This is a workaround for not being able to mutate `Leaf`'s `LeafTagConfig`.
/// - See: https://github.com/vapor/leaf/pull/113.
public final class MutableLeafTagConfig: Service {
    var storage: [String: TagRenderer] = [:]
}

extension MutableLeafTagConfig {
    /// Register multiple tags using the keys as their names.
    ///
    /// - Parameter list: Map of names to tags.
    public func use(_ list: [String: TagRenderer]) {
        for (name, tag) in list {
            storage[name] = tag
        }
    }

    /// Register a single tag.
    ///
    /// - Parameters:
    ///   - tag: the tag to register.
    ///   - name: the name for the tag to use in template files.
    public func use(_ tag: TagRenderer, as name: String) {
        storage[name] = tag
    }
}
