import Vapor

/// A protocol expressing the ability for types to be created via a related `Decodable` type.
///
/// This protocol is intended to be used with
///
///   `static func create(on req: Request) -> Future<Self>`
///
/// as defined below. This combines the `preCreate`, decoding of the associated `Create` type and
/// initialization steps. By default the `preCreate` step does not do anything but it can be
/// overloaded for use in validation, interrupting the creation process in case of invalid data.
///
/// Sometimes the `Creatable` type is the type that needs to be decoded. In those cases you can use
/// `SelfCreatable` (see below). This makes it close to the situation of simply having a `Decodable`
/// type but you have the benefit of the `preCreate` step and being able to treat it in the same
/// way as other `Creatable` types.
public protocol Creatable {

    /// Decodable Payload used to 
    associatedtype Create: Decodable

    /// A step that is to be performed during the actual creation. Can be used for validation.
    ///
    /// - Parameter req: the current `Request`.
    static func preCreate(on req: Request) -> Future<Void>

    /// Create a new instance of the conforming type based on the associated `Create` type.
    ///
    /// - Parameter create: the input for creating a new instance.
    init(_ create: Create) throws
}

extension Creatable {

    /// See `Creatable`. A default implementation that does nothing.
    public static func preCreate(on req: Request) -> Future<Void> {
        return req.future()
    }

    /// The main "interface" of Creatable. This ties together the `preCreate`, decoding and
    /// initializing steps.
    ///
    /// - Parameter req: the current `Request`.
    /// - Returns: a `Future` of the `Creatable` type.
    public static func create(on req: Request) -> Future<Self> {
        return preCreate(on: req)
            .flatMap {
                try req.content.decode(Create.self)
            }
            .map(Self.init)
    }
}

/// A special case of Creatable where the associated `Create` type is the type itself (see the
/// extension below).
public protocol SelfCreatable: Creatable, Decodable {}

extension SelfCreatable {

    /// See `Creatable`. Default implementation of `init` where the created value is directly
    /// assigned to itself.
    public init(_ create: Self) throws {
        self = create
    }
}
