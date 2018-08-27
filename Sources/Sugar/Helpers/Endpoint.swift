import Fluent
import Vapor

public typealias Endpoint = [PathComponentsRepresentable]

public protocol HasParameterValue {
    func resolveParameterValue() throws -> ParameterValue
}

public extension Model where Self: Parameter {
    public func resolveParameterValue() throws -> ParameterValue {
        guard let value = self[keyPath: Self.idKey] as? LosslessStringConvertible else {
            throw Abort(.badRequest, reason: "Could not convert ID to string.")
        }
        return ParameterValue(slug: Self.routingSlug, value: value.description)
    }
}

public extension Array where Iterator.Element == PathComponentsRepresentable {
    public func path<T>(_ parameters: [T]) throws -> String where T: Model & Parameter {
        var path = self.convertToPathComponents().readable
        for parameter in parameters {
            let parameterValue = try parameter.resolveParameterValue()
            path = path.replacingOccurrences(of: ":\(parameterValue.slug)", with: parameterValue.value)
        }

        return path
    }

    public func path<T>(_ parameter: T) throws -> String where T: Model & Parameter {
        return try path([parameter])
    }
}
