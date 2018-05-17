import Vapor

public extension Future {
    public func `try`(_ callback: @escaping (Expectation) throws -> Void) -> Future<T> {
        return map {
            try callback($0)
            return $0
        }
    }

    public func flatTry(_ callback: @escaping (Expectation) throws -> Future<Void>) -> Future<T> {
        return flatMap { expectation in
            try callback(expectation).map { _ in expectation }
        }
    }

    public func flatTry(_ callback: @escaping (Expectation) throws -> Future<Any>) -> Future<T> {
        return flatMap { expectation in
            try callback(expectation).map { _ in expectation }
        }
    }

    static func transform(to value: T, on worker: Worker) -> Future<T> {
        return Future.map(on: worker) { value }
    }
}

public extension Future where Expectation: OptionalType {
    public func `nil`(or error: @autoclosure @escaping () -> Error) -> Future<Void> {
        return map(to: Void.self) { optional in
            guard optional.wrapped == nil else {
                throw error()
            }
        }
    }
}

public extension Future where Expectation: Equatable {
    public func equal(
        _ expected: Expectation,
        or error: @autoclosure @escaping () -> Error
    ) -> Future<Void> {
        return map(to: Void.self) { value in
            guard value == expected else {
                throw error()
            }
        }
    }
}
