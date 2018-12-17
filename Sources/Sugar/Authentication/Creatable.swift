import Vapor

public protocol Creatable {
    associatedtype Create
    static func preCreate(on req: Request) -> Future<Void>
    init(_ create: Create) throws
}

public protocol SelfCreatable: Creatable, Decodable where Self.Create == Self {}

extension SelfCreatable {
    public init(_ create: Self) throws {
        self = create
    }
}

extension Creatable where Self.Create == Self {
    public init(_ create: Create) throws {
        self = create
    }
}

extension Creatable {
    public static func preCreate(on req: Request) -> Future<Void> {
        return req.future()
    }
}

extension Creatable where Create: Decodable {
    public static func create(on req: Request) -> Future<Self> {
        return preCreate(on: req)
            .flatMap {
                try req.content.decode(Create.self)
            }
            .map(Self.init)
    }
}
