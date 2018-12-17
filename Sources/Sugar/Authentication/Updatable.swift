import Vapor

public protocol Updatable: class {
    associatedtype Update
    func preUpdate(on req: Request) -> Future<Void>
    func update(_ update: Update) throws
}

extension Updatable {
    public func preUpdate(on req: Request) -> Future<Void> {
        return req.future()
    }
}

extension Updatable where Update: Decodable {
    public func applyUpdate(on req: Request) -> Future<Self> {
        return preUpdate(on: req)
            .try {
                try self.update(req.content.syncDecode(Update.self))
            }
            .transform(to: self)
    }
}
