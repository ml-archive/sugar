import Vapor
import Fluent

protocol SlugWrapable {
    static var slugField: String { get }
}

enum SlugWrapper<T: Parameterizable> {
    case id(value: Int)
    case slug(value: String)
}

extension SlugWrapper {
    static func make(for parameter: String) throws -> SlugWrapper {
        if let id = Int(parameter) {
            return SlugWrapper.id(value: id)
        } else {
            return SlugWrapper.slug(value: parameter)
        }
    }
}

extension SlugWrapper: Parameterizable {
    public static var uniqueSlug: String {
        return T.uniqueSlug
    }
}

extension SlugWrapper where T: Entity & SlugWrapable {
    internal func resolve() throws -> T {
        switch self {
        case .id(let id):
            guard let lookup = try T.find(id) else {
                throw Abort.notFound
            }
            return lookup
        case .slug(let value):
            return try T.makeQuery().filter(T.slugField, value).firstOrFail()
        }
    }
}
