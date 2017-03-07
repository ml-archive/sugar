import Vapor
import Fluent

extension QueryRepresentable {
    
    /// Returns the first entity retreived by the query
    /// If no entity is found, throw Abort.Error
    /// - Returns: T
    /// - Throws: Error
    public func firstOrFail() throws -> T {
        let query = try makeQuery()
        query.action = .fetch
        query.limit = Limit(count: 1)
        
        guard var model = try query.run().first else {
            throw Abort.custom(status: .notFound, message: "Entity was not found")
        }
        
        model.exists = true
        
        return model
    }
}
