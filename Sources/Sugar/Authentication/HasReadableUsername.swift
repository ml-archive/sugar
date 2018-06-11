public protocol HasReadableUsername {
    /// The keypath to the username, sometimes an email address.
    static var readableUsernameKey: KeyPath<Self, String> { get }
}
