import Vapor
import Fluent
import XCTest
import Foundation

@testable import Sugar

class NodesModelTests: XCTestCase {
    static var allTests = [
        ("testSoftDeleteFilterQuery", testSoftDeleteFilterQuery),
        ("testSoftDeleteFilterQueryFirst", testSoftDeleteFilterQueryFirst),
        ("testSoftDeleteFilterAll", testSoftDeleteFilterAll),
    ]
    
    override func setUp() {
        Database.default = Database(TestDriver())
    }
    
    func testSoftDeleteFilterQuery() throws {
        let allUsers = try TestUser.query().run()
        if let user = allUsers.first {
            XCTAssertEqual(user.name, "filter_applied", "filter should have applied")
        } else {
            XCTFail("Should have returned one user")
        }
    }
    
    func testSoftDeleteFilterQueryFirst() throws {
        let firstUser = try TestUser.query().first()
        if let user = firstUser {
            XCTAssertEqual(user.name, "filter_applied", "filter should have applied")
        } else {
            XCTFail("Should have returned one user")
        }
    }
    
    func testSoftDeleteFilterAll() throws {
        let allUsers = try TestUser.all()
        if let user = allUsers.first {
            XCTAssertEqual(user.name, "filter_applied", "filter should have applied")
        } else {
            XCTFail("Should have returned one user")
        }
    }
}

class TestDriver: Driver {
    var idKey: String = "id"
    
    func query<T : Entity>(_ query: Query<T>) throws -> Node {
        switch query.action {
        case .count, .fetch:
            guard query.filters.contains(where: {
                guard case .compare(let key, let comparison, _) = $0.method else {
                    return false
                }
                
                return key == "deleted_at" && comparison == .equals
            }) else {
                return .array([Node([
                    "name": "filter_not_applied"
                ])])
            }
            
            return .array([Node([
                "name": "filter_applied"
            ])])
            
        default:
            return nil
        }
    }
    
    func schema(_ schema: Schema) throws {}
    
    @discardableResult
    public func raw(_ query: String, _ values: [Node] = []) throws -> Node {
        return .null
    }
}

struct TestUser: NodesModel {
    var id: Node?
    
    var name: String
    
    var created_at: Date?
    var updated_at: Date?
    var deleted_at: Date?
    
    init(name: String, age: Int) {
        self.name = name
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "name": name
        ])
    }
    
    static func prepare(_ database: Database) throws {}
    static func revert(_ database: Database) throws {}
}
