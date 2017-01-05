import XCTest
import Fluent
import FluentMySQL

@testable import Sugar

class DatabaseMySQLTests: XCTestCase {
    
    //MARK: Indexes
    func testIndex() {
        let statement = Database.index(table: "table", column: "column")
        
        XCTAssertEqual(statement, "ALTER TABLE table ADD INDEX (column)")
    }
    
    func testIndexName() {
        let statement = Database.index(table: "table", column: "column", name: "index_test")
        
        XCTAssertEqual(statement, "ALTER TABLE table ADD INDEX index_test (column)")
    }
    
    func testForeign() {
        let statement = Database.foreign(parentTable: "table_a", parentPrimaryKey: "a", childTable: "table_b", childForeignKey: "b")
        
        XCTAssertEqual(statement, "ALTER TABLE table_b ADD CONSTRAINT table_b_table_a_a_foreign FOREIGN KEY(b) REFERENCES table_a(a)")
    }
    
    static var allTests : [(String, (DatabaseMySQLTests) -> () throws -> Void)] {
        return [
            //INDEX
            ("testIndex", testIndex),
            ("testIndexName", testIndexName),
            
            //FOREIGN
            ("testForeign", testForeign),
        ]
    }
}
