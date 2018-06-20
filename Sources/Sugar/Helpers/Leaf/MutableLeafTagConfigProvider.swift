import Leaf

/// Provider that transfers the leaf tags from the `MutableLeafTagConfig` to `Leaf`'s
/// `LeafTagConfig`.
/// This is a workaround for not being able to mutate `Leaf`'s `LeafTagConfig`.
/// - See: https://github.com/vapor/leaf/pull/113.
public final class MutableLeafTagConfigProvider: Provider {

    /// Creates an `MutableLeafTagConfigProvider`.
    public init() {}

    /// See `Provider.register`.
    public func register(_ services: inout Services) throws {
        // register LeafProvider here to ensure it does not override our `LeafTagConfig`.
        try services.register(LeafProvider())
        services.register(MutableLeafTagConfig())
        services.register { container -> LeafTagConfig in
            let mutableConfig: MutableLeafTagConfig = try container.make()
            var config = LeafTagConfig.default()
            config.use(mutableConfig.storage)
            return config
        }
    }

    /// See `Provider.didBoot`.
    public func didBoot(_ container: Container) throws -> Future<Void> {
        return .done(on: container)
    }
}
