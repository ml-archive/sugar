import Crypto

public protocol HasHashedPassword {
    static var bCryptCost: Int { get }
    var password: HashedPassword { get }
}

public struct HashedPassword: Codable, Equatable {
    public let value: String
    fileprivate init(_ input: LosslessStringConvertible) {
        value = input.description
    }
}

extension HasHashedPassword {
    public static func hashPassword(_ data: LosslessDataConvertible) throws -> HashedPassword {
        return try HashedPassword(BCrypt.hash(data, cost: bCryptCost))
    }

    public func verify(_ password: String) throws -> Bool {
        return try BCrypt.verify(password, created: self.password.value)
    }
}

// MARK: - MySQLDataConvertible

import MySQL

extension HashedPassword: MySQLDataConvertible {
    public func convertToMySQLData() throws -> MySQLData {
        return MySQLData(string: value)
    }

    public static func convertFromMySQLData(_ mysqlData: MySQLData) throws -> HashedPassword {
        return try self.init(mysqlData.decode(String.self))
    }
}
