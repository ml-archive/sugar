/// Types conforming to this protocol can be used for login or register requests.
public protocol HasReadableUsername {
    /// The keypath to the username, sometimes an email address.
    static var readableUsernameKey: KeyPath<Self, String> { get }
}
