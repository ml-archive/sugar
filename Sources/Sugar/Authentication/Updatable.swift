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
            .flatTry {
                try req.content.decode(Update.self).map(self.update)
            }
            .transform(to: self)
    }
}
