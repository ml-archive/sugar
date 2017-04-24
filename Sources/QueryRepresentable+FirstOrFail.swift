import Vapor
import Fluent

extension QueryRepresentable where Self: ExecutorRepresentable {
    
    /// Returns the first entity retreived by the query
    /// If no entity is found, throw Abort.Error
    /// - Returns: T
    /// - Throws: Error
    public func firstOrFail() throws -> E {
        let query = try makeQuery()
        query.action = .fetch
        query.limits.append(RawOr.some(Limit(count: 1)))

        guard let model = try query.first() else {
            throw Abort(
                .notFound,
                metadata: nil,
                reason: "Entity was not found"
            )
        }
        
        model.exists = true
        
        return model
    }
}
