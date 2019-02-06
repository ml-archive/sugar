import Redis

extension RedisClient {
    public func expire(_ key: String, after deadline: Int) -> Future<Int> {
        let resp = command(
            "EXPIRE", [RedisData(bulk: key), RedisData(bulk: "\(deadline)")]).map(to: Int.self
        ) { data in
            guard let value = data.int else {
                throw RedisError(identifier: "expire", reason: "Could not convert response to int")
            }

            return value
        }

        return resp
    }

    public func set<E>(
        _ key: String,
        to data: E,
        expiration: Int
    ) -> Future<Int> where E: RedisDataConvertible {
        return set(key, to: data)
            .flatMap {
                self.expire(key, after: expiration)
            }
    }

    public func jsonSet<E>(
        _ key: String,
        to entity: E,
        expiration: Int
    ) -> Future<Int> where E: Encodable {
        do {
            return try set(key, to: JSONEncoder().encode(entity))
                .flatMap {
                    return self.expire(key, after: expiration)
                }
        } catch {
            return eventLoop.newFailedFuture(error: error)
        }
    }
}
