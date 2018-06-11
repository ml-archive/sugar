public protocol HasUpdatableUsername {
    /// The keypath to the updatable username, sometimes an email address.
    static var updatableUsernameKey: KeyPath<Self, String?> { get }
}
