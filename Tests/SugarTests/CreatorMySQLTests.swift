import XCTest
import Fluent

@testable import Sugar

class CreatorMySQLTests: XCTestCase {
   
    func testString() {
        let builder = Schema.Creator("table")
        builder.string("string")
        
        let sql = builder.schema.sql
        let serializer = GeneralSQLSerializer(sql: sql)
        
        let (statement, values) = serializer.serialize()
        
        XCTAssertEqual(statement, "CREATE TABLE `table` (`string` STRING NOT NULL)")
        XCTAssertEqual(values.count, 0)
    }
    
    static var allTests : [(String, (CreatorMySQLTests) -> () throws -> Void)] {
        return [
            ("testString", testString),
        ]
    }
}
